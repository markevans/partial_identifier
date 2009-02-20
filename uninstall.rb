require "#{File.dirname(__FILE__)}/config"
require 'fileutils'

# Remove js/css files from the appropriate directories
[ PartialIdentifier.js_file_path, PartialIdentifier.css_file_path ].each do |file|
  
  puts "Removing #{file}..."
  begin
    FileUtils.rm file
    puts "...done"
  rescue
    puts '...failed'
  end

end
