require "#{File.dirname(__FILE__)}/config"
require 'fileutils'

# Put js/css files in the appropriate directories

# Make the directory
puts "Making sure directory #{PartialIdentifier::FILE_PATH} exists"
FileUtils.mkdir_p(PartialIdentifier::FILE_PATH)

asset_dir = "#{File.dirname(__FILE__)}/public"
{
  "#{asset_dir}/javascripts/jquery.partial_identifier.js"  => PartialIdentifier::FILE_PATH,
  "#{asset_dir}/stylesheets/jquery.partial_identifier.css" => PartialIdentifier::FILE_PATH
}.each do |from, to|
  
  puts "Copying #{File.basename(from)} to #{to}..."
  begin
    FileUtils.mv from, to
    puts "...done"
  rescue
    puts '...failed. Please copy this file manually from the plugin to the appropriate place.'
  end
  
end

puts "**************"
puts
puts "If you have svn/git, you may want to add"
puts "    **/partial_identifier*"
puts " to your ignore file"
puts
puts "**************"
