$(document).ready(function() { 
  $('#ajax_spinner_div').hide();
  jQuery.ajaxSetup({
    beforeSend: function() {
     $('#ajax_spinner_div').show();
    },
    complete: function(){
     $('#ajax_spinner_div').hide();
    },
    success: function() {}
  });

});
