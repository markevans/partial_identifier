Partial Identifier
==================

Ever been checking your development rails app in the browser and wanted to know which ERB file a part of your page is from?
Wanted to know the rendered file hierarchy all the way up to the layout?
Wanted to quickly open one of those files in textmate?

Now you can!! And it's easy peasy!

The only requirement is that you're using [jquery](http://jquery.com/) in your rails app.


Usage
=====

1. Install the plugin

    script/plugin install git://github.com/markevans/partial_identifier.git

2. Browse your app in development mode (after restarting the server)
   Press Shift + Ctrl + P to toggle the partial identifier on.

3. Click on a part of the page you want to inspect - this will display its partial hierarchy in the top left
   (each time you click you will update the partial hierarchy)

4. If you have textmate, clicking one of the partial links will open that file in textmate!

5. When finished, press Shift + Ctrl + P again to turn the partial identifier off.


Tweaks
======

By default the plugin installs the js/css files in the rails default directory.
If this is not correct, change one of the following in development.rb:
   
    PartialIdentifier.js_url_path   # default is "/javascripts"
    PartialIdentifier.css_url_path  # default is "/stylesheets"

    PartialIdentifier.js_file_path  # default is "#{RAILS_ROOT}/public#{js_url_path}"
    PartialIdentifier.css_file_path # default is "#{RAILS_ROOT}/public#{css_url_path}"



TODO
====

Get it to work with HAML


Copyright (c) 2008 [Mark Evans], released under the MIT license
