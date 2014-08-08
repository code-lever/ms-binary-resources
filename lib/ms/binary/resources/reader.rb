require 'open-uri'

module Ms
  module BinaryResources

    class Reader

      attr_reader :manager_magic, :manager_version, :manager_length, :resource_version,
                  :resource_count, :type_count

      def initialize(uri)
        file = open(uri, 'rb')
        @manager_magic = file.read(4).unpack('L<').first
        raise 'magic (%08X)' % manager_magic unless MAGIC_NUMBER == manager_magic

        @manager_version = file.read(4).unpack('L<').first
        @manager_length = file.read(4).unpack('L<').first

        if 1 == manager_version
          @reader_class = file.read(@manager_length)
        else
          raise 'Unsupported manager version (%d)' % manager_version
        end

        @resource_version = file.read(4).unpack('L<').first
        unless [1, 2].include?(resource_version)
          raise 'Unsupported resource version (%d)' % resource_version
        end

        @resource_count = file.read(4).unpack('L<').first
        @type_count = file.read(4).unpack('L<').first

      rescue => e
        raise ArgumentError, "File does not appear to be a resources file (#{e})"
      ensure
        file.close
      end

    end

  end
end
