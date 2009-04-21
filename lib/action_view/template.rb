class ActionView::Template

  def source
    # This monkey patch unobtrusively wraps any rendered files in a comment, which will be used by javascript
    # to create divs (when requested) for identifying the source file for each part of the page
    file_contents = File.read(self.filename)
    tag_open  = '<!-- --{JPI}'
    tag_close = '{JPI}!-- -->'
    div_open = %(#{tag_open}div class="jpi_rendered_template" id="#{self.filename}" #{tag_close})
    div_close = "#{tag_open}/div#{tag_close}"

    # Add the js/css files if we have a <head> tag
    if file_contents.match('</head>')
      js_include  = %(<script type="text/javascript" charset="utf-8" src="#{PartialIdentifier::URL_PATH}/jquery.partial_identifier.js"></script>)
      css_include = %(<link rel="stylesheet" href="#{PartialIdentifier::URL_PATH}/jquery.partial_identifier.css" type="text/css" media="screen" title="no title" charset="utf-8" />)
      file_contents.sub!('</head>',"\n#{js_include}\n#{css_include}\n</head>")
    end

    # If the file contains a body tag, make sure the div is inside this for valid XHTML...
    if file_contents.match('<body>') && file_contents.match('</body>')
      file_contents.sub! "<body>" , "<body>#{div_open}"
      file_contents.sub! "</body>", "#{div_close}</body>"
      @source ||= file_contents
    # ...otherwise we can wrap it around the entire contents
    else
      @source ||= div_open + file_contents + div_close
    end
  end

end
