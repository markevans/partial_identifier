# Include hook code here
if RAILS_ENV == 'development'
  jpi_root = File.dirname(__FILE__)
  require "#{jpi_root}/config"
  require "#{jpi_root}/lib/action_view/template"
end
