def data_file(name)
  File.expand_path("#{File.dirname(__FILE__)}/../../support/data/#{name}")
end

def invalid_data_files
  dir = "#{File.dirname(__FILE__)}/../../support/data/invalid"
  invalid = Dir.glob("#{dir}/**/*").select { |e| File.file? e }
  invalid << __FILE__
  invalid << 'not-really-a-file.resources'
end
