require 'open-uri'
require 'ostruct'

module Ms
  module BinaryResources

    class Reader

      include Enumerable

      attr_reader :manager_magic, :manager_version, :manager_length, :resource_version, :resource_count, :type_count

      def initialize(uri)
        @file = open(uri, 'rb')
        read_headers
      rescue => e
        fail ArgumentError, "file does not appear to be a resources file (#{e})"
        @file.close
      end

      def each(&block)
        keys.each { |k| block.call(k, (self[k] rescue nil)) }
      end

      def key?(name)
        info_for_name(name)
      end

      def keys
        @keys ||= @resource_infos.map(&:name)
      end

      def type_of(name)
        info = info_for_name(name)
        if info
          type = RESOURCE_TYPES.find { |_, v| info.type_index == v }
          type && type.first
        end
      end

      def [](name)
        info = info_for_name(name)
        info ? read_value(info) : nil
      end

      def close
        @file.close
        @file = nil
      end

      private

      def info_for_name(name)
        @resource_infos.find { |info| info.name.encode(name.encoding) == name }
      end

      def read_headers
        @manager_magic = read_uint32
        fail 'magic (%08X)' % manager_magic unless MAGIC_NUMBER == manager_magic

        @manager_version = read_uint32
        @manager_length = read_uint32

        if 1 == manager_version
          @reader_class = @file.read(@manager_length)
        else
          fail 'Unsupported manager version (%d)' % manager_version
        end

        @resource_version = read_uint32
        unless [1, 2].include?(resource_version)
          fail 'Unsupported resource version (%d)' % resource_version
        end

        @resource_count = read_uint32
        @type_count = read_uint32

        @type_names = @type_count.times.map { read_string }

        # next section is 8-byte aligned, there will be PADPADPAD characters to make it so
        pad_alignment = @file.pos & 0x07
        pad_count = pad_alignment > 0 ? 8 - pad_alignment : 0
        padding = @file.read(pad_count)

        @hashes = resource_count.times.map { read_uint32 }
        @positions = resource_count.times.map { read_uint32 }

        @data_section_offset = read_uint32
        @name_section_offset = @file.pos

        # cache the file location and type of all resources
        @resource_infos = @positions.map { |pos| read_resource_info(pos) }
      end

      def read_resource_info(name_position)
        seek_to_name(name_position)
        length = read_7bit_encoded_int
        name = read(length).encode('UTF-16LE', 'UTF-16LE')

        seek_to_data(read_uint32)
        type_index = read_7bit_encoded_int

        OpenStruct.new(name: name, value_position: @file.pos, type_index: type_index)
      end

      def read(bytes)
        @file.read(bytes)
      end

      def read_byte
        read(1).unpack('C').first
      end

      def read_int16
        read(2).unpack('s<').first
      end

      def read_uint16
        read(2).unpack('S<').first
      end

      def read_int32
        read(4).unpack('l<').first
      end

      def read_uint32
        read(4).unpack('L<').first
      end

      def read_int64
        read(8).unpack('q<').first
      end

      def read_uint64
        read(8).unpack('Q<').first
      end

      def read_7bit_encoded_int
        ret = 0
        shift = 0

        begin
          b = read_byte
          ret |= (b & 0x7f) << shift
          shift += 7
        end while (b & 0x80) == 0x80

        ret
      end

      def read_string
        read(read_7bit_encoded_int)
      end

      def read_value(resource_info)
        @file.seek(resource_info.value_position)

        case resource_info.type_index
        when RESOURCE_TYPES[:string]; read_string
        when RESOURCE_TYPES[:int16];  read_int16
        when RESOURCE_TYPES[:uint16]; read_uint16
        when RESOURCE_TYPES[:int32];  read_int32
        when RESOURCE_TYPES[:uint32]; read_uint32
        when RESOURCE_TYPES[:int64];  read_int64
        when RESOURCE_TYPES[:uint64]; read_uint64
        else
          fail 'Unsupported type index: %d' % resource_info.type_index
        end
      end

      def seek_to_name(position)
        @file.seek(@name_section_offset + position)
      end

      def seek_to_data(position)
        @file.seek(@data_section_offset + position)
      end

    end

  end
end
