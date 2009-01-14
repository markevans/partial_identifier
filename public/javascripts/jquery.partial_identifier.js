;(function($) {

  var jpi_selector = 'div.jpi_rendered_template'
  var jpi_message_box_class = 'jpi_message_box'
  var jpi_message_box_selector = '.'+jpi_message_box_class
  var jpi_selected_class = 'jpi_selected'
  var jpi_on = false;
  var jpi_on_string = '><!--JPI--><'
  var jpi_off_string = '{JPI}'

  $.fn.extend({

    templateStackContainers : function(){
      if( $(this).is(jpi_selector) ){
        return $(this).children().parents(jpi_selector)
      } else {
        return $(this).parents(jpi_selector)
      }
    },
  
    templateStackAsList : function(){
      var lis = $(this).templateStackContainers().map(function(){
        var file_parts = this.id.split('/')
        var text = file_parts[file_parts.length-1]
        return '<li><a href="txmt://open/?url=file://' + this.id + '">' + text + '</a></li>'
      }).get().reverse().join("\n")
      return '<ul>' + lis + '</ul>'
    }
  
  });

  var updateTemplateList = function(evt){
    $(jpi_message_box_selector).html( $(evt.target).templateStackAsList() )
    return false
  }
  
  var addHoverClass = function(evt){
    $(evt.target).templateStackContainers().eq(0).addClass(jpi_selected_class)
    evt.stopPropagation()
  }
  
  var removeHoverClass = function(evt){
    $(evt.target).templateStackContainers().eq(0).removeClass(jpi_selected_class)
    evt.stopPropagation()
  }
  
  var toggleJpi = function(){
    
    if(jpi_on){ // Turn OFF
      
      $(jpi_message_box_selector).remove()
      $(jpi_selector).unbind('click'    , updateTemplateList)
      $(jpi_selector).unbind('mouseover', addHoverClass)
      $(jpi_selector).unbind('mouseout' , removeHoverClass)
      
      $('body').html( $('body').html().replace(jpi_on_string, jpi_off_string, 'g') )

      $('body').removeClass('jpi_on')

      jpi_on = false

    } else { // Turn ON
      
      $('body').addClass('jpi_on')
      
      $('body').html( $('body').html().replace(jpi_off_string, jpi_on_string, 'g') )
      
      $(jpi_selector).bind('click'    , updateTemplateList)
      $(jpi_selector).bind('mouseover', addHoverClass)
      $(jpi_selector).bind('mouseout' , removeHoverClass)
      
      // Notify that partial identifier is on
      $('body').append('<div class="' + jpi_message_box_class + '"></div>')
      $(jpi_message_box_selector).html('Template Identifier On')
      
      jpi_on = true
      
    }
  }
  
  // Start the partial identifier when you press certain keys
  $(window).keydown(function (e) {
    // If the key combo is Ctrl + P...
    if(e.which == 17) isCtrl=true;
    if(e.which == 80 && isCtrl == true) {
      toggleJpi()
    }
  })

})(jQuery);