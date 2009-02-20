module PartialIdentifier

  class << self
    attr_accessor :js_url_path, :css_url_path, :js_file_path, :css_file_path
  end

  js_url_path  = "/javascripts"
  css_url_path = "/stylesheets"
  
  js_file_path  = "#{RAILS_ROOT}/public#{js_url_path}"
  css_file_path = "#{RAILS_ROOT}/public#{css_url_path}"
  
end