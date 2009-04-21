require "#{File.dirname(__FILE__)}/config"
require 'fileutils'

# Remove js/css files from the appropriate directories
puts "Removing #{PartialIdentifier::FILE_PATH}..."
FileUtils.rm_rf PartialIdentifier::FILE_PATH
