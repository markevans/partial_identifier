require "#{File.dirname(__FILE__)}/config"
require 'fileutils'

# Put js/css files in the appropriate directories
asset_dir = "#{File.dirname(__FILE__)}/public"
{
  "#{asset_dir}/javascripts/jquery.partial_identifier.js" => PartialIdentifier.js_file_path,
  "#{asset_dir}/stylesheets/jquery.partial_identifier.css" => PartialIdentifier.css_file_path
}.each do |from, to|
  
  puts "Moving #{File.basename(from)} to #{to}..."
  FileUtils.mv from, to
  puts "...done"

end
