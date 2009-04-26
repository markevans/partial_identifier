require "#{File.dirname(__FILE__)}/config"
require 'fileutils'

# Put js/css files in the appropriate directories

# Make the directory
puts "Making sure directory #{PartialIdentifier::FILE_PATH} exists"
FileUtils.mkdir_p(PartialIdentifier::FILE_PATH)

%w{partial_identifier.js partial_identifier.css}.each do |file|
  
  src = "#{File.dirname(__FILE__)}/public/partial_identifier/#{file}"
  dest = PartialIdentifier::FILE_PATH
  
  puts "Copying #{File.basename(src)} to #{dest}..."
  begin
    FileUtils.mv src, dest
    puts "...done"
  rescue
    puts '...failed. Please copy this file manually from the plugin to the appropriate place.'
  end
  
end

puts "**************"
puts
puts "If you have git, you may want to add"
puts
puts "#{PartialIdentifier::FILE_PATH.sub(RAILS_ROOT,'').sub(%r(^/),'')}"
puts "vendor/plugins/partial_identifier"
puts
puts " to your ignore file"
puts
puts "**************"
