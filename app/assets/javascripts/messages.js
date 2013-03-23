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

  $("#received_all").click(function() {
     if ($(this).hasClass("none_selected")) 
     {
	$(".received_checkbox").prop("checked", true);	
	$(this).removeClass("none_selected");
     }
     else
     {
	$(".received_checkbox").prop("checked", false);
	$(this).addClass("none_selected")
     }
  });

  $("#sent_all").click(function() {
     if ($(this).hasClass("none_selected")) 
     {
	$(".sent_checkbox").prop("checked", true);	
	$(this).removeClass("none_selected");
     }
     else
     {
	$(".sent_checkbox").prop("checked", false);
	$(this).addClass("none_selected")
     }
  });


});

