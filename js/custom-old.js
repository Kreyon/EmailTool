
function workflow_tasks_slide() {
	jQuery('#tasks > .tasks-bar .task-name i').click(function(){
		jQuery('.tasks-row').removeClass('active');
		jQuery('.slide-task').addClass('slide-right');
		jQuery(this).closest('.tasks-row').addClass('active');
	});
	jQuery('.close-task').click(function(){
		jQuery('.slide-task').removeClass('slide-right');
		jQuery('.tasks-row').removeClass('active');
		jQuery(this).closest('.tasks-row').removeClass('active');
	});
	jQuery('.task-sidebar .toggle-arrow').click(function(){
		jQuery('.task-sidebar').toggleClass('task-sidebar-slide');
	});
	// jQuery('.top-tabs .added').click(function(){
 //        jQuery(this).before("<li class='nav-item'><span><input type='text' placeholder='Search'></span><a class='nav-link' id='append-t2-tab' data-toggle='tab' href='#append-t2' role='tab' aria-controls='append-t2' aria-selected='false'></a></li>").append(function(){
 //        	jQuery('.top-tabs li span input').css({'width':'100%'});
 //        });
 //    });

 //    jQuery(".top-tabs li span input").keyup(function(){
	//     if(jQuery(this).val() != '' ){
	//     	jQuery(this).addClass('add-val');	
	//     }
	//     else{
	//     	jQuery(this).removeClass('add-val');
	//     }
	// });

	// jQuery( ".top-tabs li span input" ).keyup(function() {
 //    	var value = jQuery( this ).val();
 //    	jQuery( this ).closest('span').next('.nav-link').text( value );
	//   })
	//   .keyup();


	jQuery(function() {
	  var $tabs = jQuery("#tabs").tabs(),
	    $dialog = jQuery("#new_tab_dialog").dialog({
	      autoOpen: false,
	      height: 200,
	      width: 350,
	      modal: true,
	      buttons: {
	        "Create a new tab": function() {
	          $dialog.dialog("close");
	          var tid = parseInt(jQuery(".tab").last().attr("id").replace("tab", "")) + 1,
	            li = jQuery("<li/>").insertBefore("#list > li:last");
	          jQuery("<a/>", {
	            text: jQuery("#new_tab_input").val(),
	            href: "#tab" + tid
	          }).appendTo(li);
	          jQuery("#tabs div.tab:last").clone().attr("id", "tab" + tid).appendTo("#tabs");
	          $tabs.tabs("refresh").tabs("option", "active", -2);
	          alert(tid);
	        },
	        Cancel: function() {
	          $dialog.dialog("close");
	        }
	      },
	      open: function() {
	        jQuery("#new_tab_input").val("");
	      }
	    });

	  jQuery("#create_tab").click(function() {
	    $dialog.dialog("open");
	  });
	});
}

jQuery(document).ready(function(){
	workflow_tasks_slide();
});	


function re_call_js() {
	mycharts();
	workflow_tasks_slide();	
	make_nav_active();
}

jQuery(document).ready(function($) {
  $(".link-page").click(function(e) {
    e.preventDefault();
	var url = $(this).attr('href');
	var host = window.location.protocol + "//" + window.location.hostname
	var uri = url.replace(host, '');
    $.get( url, { "_v" : new Date().getTime(),"ajax": "get" }, function( data ) {      
      $("#main-panel").html(data);
		history.pushState(null, null, uri);
		re_call_js();
	  
    });
  });
});