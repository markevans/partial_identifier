require "#{File.dirname(__FILE__)}/config"
require 'fileutils'

# Remove js/css files from the appropriate directories
[
  "#{PartialIdentifier.js_file_path}/jquery.partial_identifier.js",
  "#{PartialIdentifier.css_file_path}/jquery.partial_identifier.css",
].each do |file|
  
  puts "Removing #{file}..."
  begin
    FileUtils.rm file
    puts "...done"
  rescue
    puts '...failed. Please remove this file manually.'
  end

end
