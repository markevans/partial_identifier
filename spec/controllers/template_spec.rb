require File.expand_path(File.dirname(__FILE__) + "/../../../../../spec/spec_helper")

class TestController < ActionController::Base
  
  def test_action
    self.append_view_path File.expand_path("#{File.dirname(__FILE__)}/../erb")
  end

end

describe TestController do
  
  integrate_views
  
  it "should render the templates normally when not in development mode" do
    
    get :test_action
    response.body.gsub(/\s+/,' ').strip.should  == %(
    
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>Hullaballoo</title>
    </head>
    <body>
      Stuff
      Grandad start
      Mum start
      Kid
      Kid
      Mum end
      Dad start
      Kid
      Kid
      Dad end
      Grandad end
      Then some
      Grandma start
      Mum start
      Kid
      Kid
      Mum end
      Dad start
      Kid
      Kid
      Dad end
      Grandma end
      Other stuff
    </body>
    </html>

).gsub(/\s+/,' ').strip
    
  end
  
  it "should put in partial identification comments when in development mode" do
    pending "Not sure how to test in 'development' mode at the moment"
  end

end