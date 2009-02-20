require "#{File.dirname(__FILE__)}/config"
require 'fileutils'

# Put js/css files in the appropriate directories
asset_dir = "#{File.dirname(__FILE__)}/public"
{
  "#{asset_dir}/javascripts/jquery.partial_identifier.js"  => PartialIdentifier.js_file_path,
  "#{asset_dir}/stylesheets/jquery.partial_identifier.css" => PartialIdentifier.css_file_path
}.each do |from, to|
  
  puts "Copying #{File.basename(from)} to #{to}..."
  begin
    FileUtils.mv from, to
    puts "...done"
  rescue
    puts '...failed. Please copy this file manually from the plugin to the appropriate place.'
  end
  puts "**************"
  puts "If you need the js/css files to be in a different place, you can modify the following config attributes:"
  puts "PartialIdentifier.js_file_path, PartialIdentifier.css_file_path, PartialIdentifier.js_url_path and PartialIdentifier.css_url_path."
  puts "**************"
  
end
