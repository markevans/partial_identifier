module ActionView
  class Template

    def source
      # This monkey patch unobtrusively wraps any rendered files in a comment, which will be used by javascript
      # to create divs (when requested) for identifying the source file for each part of the page
      file_contents = File.read(self.filename)
      start_div = %(<div class="_jpi_marker _jpi_start" id="#{self.filename}" style="display:none;" ></div>)
      end_div = %(<div class="_jpi_marker _jpi_end" id="#{self.filename}" style="display:none;"></div>)

      # Add the js/css files if we have a <head> tag
      if file_contents.match('</head>')
        jquery_include = %(<script type="text/javascript" charset="utf-8" src="#{PartialIdentifier::URL_PATH}/jquery-1.3.2.min.js"></script>)
        js_include  = %(<script type="text/javascript" charset="utf-8" src="#{PartialIdentifier::URL_PATH}/partial_identifier.js"></script>)
        css_include = %(<link rel="stylesheet" href="#{PartialIdentifier::URL_PATH}/partial_identifier.css" type="text/css" media="screen" title="no title" charset="utf-8" />)
        file_contents.sub!('</head>',"\n#{jquery_include}\n#{js_include}\n#{css_include}\n</head>")
      end

      # If the file contains a body tag, make sure the div is inside this for valid XHTML...
      if file_contents.match('<body>') && file_contents.match('</body>')
        file_contents.sub! "<body>" , "<body>#{start_div}"
        file_contents.sub! "</body>", "#{end_div}</body>"
        result = file_contents
      # ...otherwise we can wrap it around the entire contents
      else
        result = start_div + file_contents + end_div
      end
      
      # Rails since 2.3 or so they use the :memoize method so cater for that here
      defined?('Memoizable') ? result : (@source ||= result)
    end

  end

end