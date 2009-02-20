module PartialIdentifier

  class << self
    attr_accessor :js_url_path, :css_url_path, :js_file_path, :css_file_path
  end

  self.js_url_path  = "/javascripts"
  self.css_url_path = "/stylesheets"
  
  self.js_file_path  = "#{RAILS_ROOT}/public#{js_url_path}"
  self.css_file_path = "#{RAILS_ROOT}/public#{css_url_path}"
  
end