;(function($) {

  var jpi_on = false;

  $.count = function(array, arg){
    if(typeof(arg) == 'function') callback = arg;
    else if(typeof(arg) == 'undefined') callback = function(){return true;};
    else callback = function(n){return n == arg;};
    
    return $.grep(array, callback).length;
  };

  $.fn.extend({
    
    // The following two functions are taken (modified) from
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
      var opened_partials = $(this).prevALL('._jpi_start').map(function(){return this.id;});
      var closed_partials = $(this).prevALL('._jpi_end').map(function(){return this.id;});
      // The stack is the opened partials, minus any closed ones
      var stack = [];
      var num_opened = null;
      var num_closed = null;
      $.each(opened_partials, function(){
        partial_path = String(this);
        num_opened = $.count(opened_partials, partial_path);
        num_closed = $.count(closed_partials, partial_path);
        // If more of that partial opened than closed, and not already in stack
        if(num_opened > num_closed && $.inArray(partial_path,stack) == -1) stack.push(partial_path);
      });
      // Go up a level
      return stack;
    },
  
    partialStackAsList : function(){
      var lis = $.map($(this).partialStack(), function(partial_path){
        var file_parts = partial_path.split('/');
        var text = file_parts[file_parts.length-1];
        return '<li><a class="_jpi_link" href="txmt://open/?url=file://' + partial_path + '">' + text + '</a></li>';
      }).reverse().join("\n");
      return '<ul>' + lis + '</ul>';
    }
  
  });

  var display = function(message){
    if($('#_jpi_message_box').length == 0) {
      $('body').append('<div id="_jpi_message_box"><h3>Partial identifier</h3><div></div></div>');
    }
    $('#_jpi_message_box div').html(message);
  };

  var warn = function(message){
    if($('#_jpi_warning_message_box').length == 0) {
      $('body').append('<div id="_jpi_warning_message_box"></div>');
    }
    var box = $('#_jpi_warning_message_box');
    box.html(message).css({left: ($(window).width()/2.0 - box.width()/2.0) });
  };
  
  var removeWarning = function(){
    $('#_jpi_warning_message_box').fadeOut(8000, function(){$(this).remove();});
  };
  
  var turnOffLinks = function(){
    return false;
  };
  
  var updateTemplateList = function(evt){
    display( $(evt.target).partialStackAsList() );
    return true;
  };
  
  var toggleJpi = function(){
    
    if(jpi_on){ // Turn OFF
      
      display('Turning OFF');
      $('#_jpi_message_box').fadeOut(3000, function(){$(this).remove();});
      $('*').unbind('click', updateTemplateList);
      $('*').unbind('click', turnOffLinks);
      $('body').removeClass('jpi_on');
      jpi_on = false;

    } else { // Turn ON
      
      if($('#_firebugConsole').length > 0) warn("Make sure the firebug panel is closed<br />as this makes partial identifier slower<br />when turning on");
      $('body').addClass('jpi_on');
      $('a, input[type=submit], button').click(turnOffLinks);
      $('*').click(updateTemplateList);
      setTimeout(function(){},5000);
      display('');
      removeWarning();
      jpi_on = true;
      
    }
  };
  
  // Start the partial identifier when you press certain keys
  $(window).keydown(function (e) {
    // If the key combo is Ctrl + P...
    if(e.which == 17) isCtrl=true;
    if(e.which == 80 && isCtrl == true) {
      toggleJpi();
    }
  });

})(jQuery);