Partial Identifier
==================

Ever been checking your development rails app in the browser and wanted to know which ERB file a part of your page is from?
Wanted to know the rendered file hierarchy all the way up to the layout?
Wanted to quickly open one of those files in textmate?

Now you can!! And it's easy peasy!


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

Notes
=====
- This only works in development mode, so won't interfere with anything on production
- If you're using version control you will probably want to ignore the created files as it's useful for your development only
- It is fairly unobtrusive to the page DOM - it simply inserts invisible divs
- It uses the bundled version of jquery if you don't already have it, otherwise uses the one you're using

TODO
====

Get it to work with HAML


Copyright (c) 2008 [Mark Evans], released under the MIT license
