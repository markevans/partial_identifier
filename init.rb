# Include hook code here
if RAILS_ENV == 'development'
  require File.join(File.dirname(__FILE__), 'lib', 'action_view', 'template')
end
