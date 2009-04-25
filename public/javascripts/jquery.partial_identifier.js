;(function($) {

  var jpi_message_box_class = 'jpi_message_box'
  var jpi_message_box_selector = '.'+jpi_message_box_class
  var jpi_on = false;

  $.count = function(array, arg){
    if(typeof(arg) == 'function') callback = arg;
    else if(typeof(arg) == 'undefined') callback = function(){return true};
    else callback = function(n){return n == arg};
    
    return $.grep(array, callback).length
  };

  $.fn.extend({
    
    isStartMarker : function(){
      return $(this).hasClass('_jpi_start')
    },
    
    isEndMarker : function(){
      return $(this).hasClass('_jpi_end')
    },
    
    // The following two functions are stolen from 
    // http://stackoverflow.com/questions/322912/jquery-to-find-all-previous-elements-that-match-an-expression
    
    reverse : function(){
      return this.pushStack(this.get().reverse(), arguments);
    },
    
    // Get ALL previous elements matching the expression - not just siblings
    prevALL : function(matchExpr) {
        // get all the elements in the body, including the body.
        var all = $('body').find('*').andSelf();

        // slice the 'all' object to only include previous elements
        var allPrev = all.slice(0, all.index(this)).reverse();
        
        // filter the matches if specified
        if (matchExpr) allPrev = allPrev.filter(matchExpr);

        return allPrev;
    },
    
    //////////////////////
    
    partialStack : function(){
      // Get all the previous opened and closed partials
      var opened_partials = $(this).prevALL('._jpi_start').map(function(){return this.id});
      var closed_partials = $(this).prevALL('._jpi_end').map(function(){return this.id});
      // The stack is the opened partials, minus any closed ones
      var stack = [];
      var num_opened = null;
      var num_closed = null;
      $.each(opened_partials, function(){
        num_opened = $.count(opened_partials, this);
        num_closed = $.count(closed_partials, this);
        // If more of that partial opened than closed, and not already in stack
        if(num_opened > num_closed && $.inArray(this,stack) == -1) stack.push(this);
      });
      // Go up a level
      return stack;
    },
  
    partialStackAsList : function(){
      var lis = $.map($(this).partialStack(), function(partial_path){
        var file_parts = partial_path.split('/')
        var text = file_parts[file_parts.length-1]
        return '<li><a href="txmt://open/?url=file://' + partial_path + '">' + text + '</a></li>'
      }).reverse().join("\n")
      return '<ul>' + lis + '</ul>'
    }
  
  });

  var updateTemplateList = function(evt){
    $(jpi_message_box_selector).html( $(evt.target).partialStackAsList() )
    return false
  }
  
  var toggleJpi = function(){
    
    if(jpi_on){ // Turn OFF
      
      $(jpi_message_box_selector).remove()
      $('*').click(updateTemplateList)
      
      $('body').removeClass('jpi_on')

      jpi_on = false

    } else { // Turn ON
      
      $('body').addClass('jpi_on')
      
      $('*').click(updateTemplateList)
      
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