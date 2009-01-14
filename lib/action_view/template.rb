class ActionView::Template

  def source
    # This monkey patch wraps any rendered files in a div which shouldn't interfere with
    # page flow, however can be used by javascript to determine which template file a section
    # of the page came from
    file_contents = File.read(self.filename)
    div_open = %Q{<div class="jpi_rendered_template" id="#{self.filename}">}
    div_close = '</div>'
    # If the file contains a body tag, make sure the div is inside this for valid XHTML...
    if file_contents.sub!("<body>", "<body>#{div_open}") and file_contents.sub!("</body>", "#{div_close}</body>")
      @source ||= file_contents
    # ...otherwise we can wrap it around the entire contents
    else
      @source ||= div_open + file_contents + div_close
    end
  end

end
