$(document).ready(function() { 
  $('a').tooltip(); 
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


  $('#ajax_spinner_file_upload').hide();

  $('#resource_file_submit').click(function() {
      $('#ajax_spinner_file_upload').show();
  });

});
