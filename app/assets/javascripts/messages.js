$(document).ready(function() {  
  $("#sent_messages").hide();

  $("#sent_tab").click(function() {
     $("#sent_messages").show(); 
     $("#received_messages").hide();
     $("#sent_tab").addClass("active");
     $("#received_tab").removeClass("active");
  });

  $("#received_tab").click(function() {
     $("#received_messages").show(); 
     $("#sent_messages").hide();
     $("#received_tab").addClass("active");
     $("#sent_tab").removeClass("active");
  });



});

