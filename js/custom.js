var tester;

function workflow_tasks_slide() {
	jQuery(document).on('click','#tasks > .tasks-bar .task-name i, .task-sidebar .tasks-bar .task-name i',function(){
		jQuery('.tasks-row').removeClass('active');
		jQuery('.slide-task').addClass('slide-right');
		jQuery(this).closest('.tasks-row').addClass('active');
	});
	jQuery(document).on('click','.close-task',function(){
		jQuery('.slide-task').removeClass('slide-right');
		jQuery('.tasks-row').removeClass('active');
		jQuery(this).closest('.tasks-row').removeClass('active');
	});
	jQuery(document).on('click','.task-sidebar .toggle-arrow',function(){
		jQuery('.task-sidebar').toggleClass('task-sidebar-slide');
	});
	jQuery(document).on('click','.top-tabs.append-tab li .fa-close',function(){
		var theID1 = jQuery(this).closest('li').attr('data-ids');
		console.log("as");
		jQuery("#"+theID1).animate({'width':'0px'}, '1000', function() { jQuery("#"+theID1).remove(); });
		jQuery("."+theID1).animate({'width':'0px'}, '1000', function() { jQuery("."+theID1).remove(); jQuery(".top-tabs .nav-link").click();} );
		
		/*jQuery("#"+theID1).fadeOut(500, function() { jQuery("#"+theID1).remove(); });
		jQuery("."+theID1).fadeOut(500, function() { jQuery("."+theID1).remove(); jQuery(".top-tabs .nav-link").click();});*/
		
		/*jQuery("#"+theID1).hide("slide", { direction: "left" }, 1000, function(){ jQuery("#"+theID1).remove(); });
		jQuery("."+theID1).hide("slide", { direction: "left" }, 1000, function(){ jQuery("."+theID1).remove(); jQuery(".top-tabs .nav-link").click(); });*/
		
		/*jQuery("#"+theID1).remove();
		jQuery("."+theID1).remove();
		jQuery(".top-tabs .nav-link").click();*/

		
	});
	jQuery(document).on('click','.h-search .home-ico',function(){
		jQuery(this).closest('li').parent('.main-serch').toggleClass('aaa');
		jQuery('.navbar-nav-right').toggleClass('aaa');
	});	
}

jQuery(document).ready(function () {
    jQuery('.top-tabs.append-tab').mousewheel(function(e, delta) {
        this.scrollLeft -= (delta * 40);
        e.preventDefault();
    });
    
});

function tabbing() {
	
	jQuery('.added.nav-item').click(function(){
		
		var test = jQuery('a[id^="appendtabt"]:last'); 
		var num;
		if(test.length > 0) {
			num = parseInt( test.prop("id").match(/\d+/g), 10 ) +2; 
		}
		else {
			num = 1;
		}
		
		//var $klon = test.clone().prop('id', 'appendtabt'+num );

		//test.after( $klon.text('appendtabt'+num) );

        jQuery(this).before("<li class='nav-item newinstab tester'><span><input type='text' style='color:#ccc' placeholder='Search' class='biginput input-insert"+num+"' ></span></li>").append(function(){
			
        	jQuery('.top-tabs li span input').css({'width':'100%'});
        	search();
        });
		jQuery(".top-tabs.append-tab").append("<li class='nav-item append-t"+num+"' id='dynamichtm"+num+"' data-ids='append-t"+num+"'></li>");
		
        jQuery(this).prev('li').animate({'max-width':'252px'}, '1000');


		jQuery(".added button").attr('disabled',true);
		
		jQuery(".input-insert"+num).blur(function(){
			var valuetab = jQuery(this).val();
			if (valuetab == '') {
				var valuetab = "Untitled";
			}
			jQuery(".input-insert"+num).hide();
			//jQuery(".atagshow").text(valuetab);
			jQuery("#dynamichtm"+num).html("<a class='nav-link' style='width:0px;' class='atagshow' id='appendtabt"+num+"' data-toggle='tab' href='#append-t"+num+"' role='tab' aria-controls='append-t"+num+"' aria-selected='false' ><div class='main-tab-bar'><div class='tab-img'><img src='http://www.aghadiinfotechforclient3.com/server19/closia-green/images/tab-img1.jpg' alt=''></div><p>"+valuetab+"</p></div></a><i class='fa fa-close' aria-hidden='true'></i>");
			

			//jQuery("#appendtabt"+num+"").animate({'width':'auto'}, '1000');
			jQuery(".newinstab").html("");
			jQuery(".added button").attr('disabled',false);
			
			var clone;
			
			//var klone = jQuery("#append-t1").clone().prop('id','append-t'+num);
			var onum = 2;
			if(jQuery(".head-tab").length > 0) {
				klone = jQuery(".head-tab:last").clone().prop('id','append-t'+num);
				onum = parseInt( jQuery(".head-tab:last").prop("id").match(/\d+/g), 10 );
			}
			else {
				klone = tester.clone().prop('id','append-t'+num);
			}
				//klone.find("#append-t1").attr("id", 'append-t'+num);
				//klone.find("#append-t"+num+" h2").text("General - "+valuetab);
				jQuery("h2", klone).text(valuetab);
				
				klone.find("#topbar-tab-outer"+onum+"-1").attr("id","topbar-tab-outer"+num+"-1");
					klone.find("#topbar-tab"+onum+"-1").attr("id","topbar-tab"+num+"-1");
					//klone.find("#topbar-tab"+onum+"-1").attr("href","#topbar-tab"+num+"-1qqq");
					//klone.attr("href",klone.attr('href').replace("989989"));
					
					klone.find("a[href^='#topbar-tab"+onum+"-1']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#topbar-tab"+num+"-1");
					});
					
					
				klone.find("#topbar-tab-outer"+onum+"-2").attr("id","topbar-tab-outer"+num+"-2");
					klone.find("#topbar-tab"+onum+"-2").attr("id","topbar-tab"+num+"-2");
					klone.find("a[href^='#topbar-tab"+onum+"-2']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#topbar-tab"+num+"-2");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

					
				klone.find("#topbar-tab-outer"+onum+"-3").attr("id","topbar-tab-outer"+num+"-3");
					klone.find("#topbar-tab"+onum+"-3").attr("id","topbar-tab"+num+"-3");
					klone.find("a[href^='#topbar-tab"+onum+"-3']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#topbar-tab"+num+"-3");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

				klone.find("#topbar-tab-outer"+onum+"-4").attr("id","topbar-tab-outer"+num+"-4");
					klone.find("#topbar-tab"+onum+"-4").attr("id","topbar-tab"+num+"-4");
					klone.find("a[href^='#topbar-tab"+onum+"-4']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#topbar-tab"+num+"-4");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

				klone.find("#topbar-tab-outer"+onum+"-5").attr("id","topbar-tab-outer"+num+"-5");
					klone.find("#topbar-tab"+onum+"-5").attr("id","topbar-tab"+num+"-5");
					klone.find("a[href^='#topbar-tab"+onum+"-5']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#topbar-tab"+num+"-5");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});
					
				klone.find("#topbar-tab-outer"+onum+"-6").attr("id","topbar-tab-outer"+num+"-6");
					klone.find("#topbar-tab"+onum+"-6").attr("id","topbar-tab"+num+"-6");
					klone.find("a[href^='#topbar-tab"+onum+"-6']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#topbar-tab"+num+"-6");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

				klone.find("#topbar-tab-outer"+onum+"-7").attr("id","topbar-tab-outer"+num+"-7");
					klone.find("#topbar-tab"+onum+"-7").attr("id","topbar-tab"+num+"-7");
					klone.find("a[href^='#topbar-tab"+onum+"-7']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#topbar-tab"+num+"-7");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

				klone.find("#topbar-tab-outer"+onum+"-8").attr("id","topbar-tab-outer"+num+"-8");
					klone.find("#topbar-tab"+onum+"-8").attr("id","topbar-tab"+num+"-8");
					klone.find("a[href^='#topbar-tab"+onum+"-8']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#topbar-tab"+num+"-8");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

				klone.find("#topbar-tab-outer"+onum+"-9").attr("id","topbar-tab-outer"+num+"-9");
					klone.find("#topbar-tab"+onum+"-9").attr("id","topbar-tab"+num+"-9");
					klone.find("a[href^='#topbar-tab"+onum+"-9']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#topbar-tab"+num+"-9");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});


					klone.find("#mid-tab-outer"+onum+"-1").attr("id","mid-tab-outer"+num+"-1");
					klone.find("#mid-tab"+onum+"-1").attr("id","mid-tab"+num+"-1");
					klone.find("a[href^='#mid-tab"+onum+"-1']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#mid-tab"+num+"-1");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					}); 
					
					klone.find("#mid-tab-outer"+onum+"-2").attr("id","mid-tab-outer"+num+"-2");
					klone.find("#mid-tab"+onum+"-2").attr("id","mid-tab"+num+"-2");
					klone.find("a[href^='#mid-tab"+onum+"-2']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#mid-tab"+num+"-2");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					}); 
					
					klone.find("#mid-tab-outer"+onum+"-3").attr("id","mid-tab-outer"+num+"-3");
					klone.find("#mid-tab"+onum+"-3").attr("id","mid-tab"+num+"-3");
					klone.find("a[href^='#mid-tab"+onum+"-3']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#mid-tab"+num+"-3");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

					klone.find("#mid-tab-outer"+onum+"-4").attr("id","mid-tab-outer"+num+"-4");
					klone.find("#mid-tab"+onum+"-4").attr("id","mid-tab"+num+"-4");
					klone.find("a[href^='#mid-tab"+onum+"-4']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#mid-tab"+num+"-4");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

					klone.find("#mid-tab-outer"+onum+"-5").attr("id","mid-tab-outer"+num+"-5");
					klone.find("#mid-tab"+onum+"-5").attr("id","mid-tab"+num+"-5");
					klone.find("a[href^='#mid-tab"+onum+"-5']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#mid-tab"+num+"-5");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					}); 

					klone.find("#mid-tab-outer"+onum+"-6").attr("id","mid-tab-outer"+num+"-6");
					klone.find("#mid-tab"+onum+"-6").attr("id","mid-tab"+num+"-6");
					klone.find("a[href^='#mid-tab"+onum+"-6']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#mid-tab"+num+"-6");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

					klone.find("#mid-tab-outer"+onum+"-7").attr("id","mid-tab-outer"+num+"-7");
					klone.find("#mid-tab"+onum+"-7").attr("id","mid-tab"+num+"-7");
					klone.find("a[href^='#mid-tab"+onum+"-7']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#mid-tab"+num+"-7");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

					klone.find("#mid-tab-outer"+onum+"-8").attr("id","mid-tab-outer"+num+"-8");
					klone.find("#mid-tab"+onum+"-8").attr("id","mid-tab"+num+"-8");
					klone.find("a[href^='#mid-tab"+onum+"-8']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#mid-tab"+num+"-8");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

					klone.find("#mid-tab-outer"+onum+"-9").attr("id","mid-tab-outer"+num+"-9");
					klone.find("#mid-tab"+onum+"-9").attr("id","mid-tab"+num+"-9");
					klone.find("a[href^='#mid-tab"+onum+"-9']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#mid-tab"+num+"-9");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

					//==========================

					klone.find("#slide-tasks-tab"+onum+"-1").attr("id","slide-tasks-tab"+num+"-1");
					klone.find("#tasks"+onum+"-1").attr("id","tasks"+num+"-1");
					klone.find("a[href^='#tasks"+onum+"-1']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#tasks"+num+"-1");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					}); 
					
					klone.find("#slide-tasks-tab"+onum+"-2").attr("id","slide-tasks-tab"+num+"-2");
					klone.find("#tasks"+onum+"-2").attr("id","tasks"+num+"-2");
					klone.find("a[href^='#tasks"+onum+"-2']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#tasks"+num+"-2");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					}); 
					
					klone.find("#slide-tasks-tab"+onum+"-3").attr("id","slide-tasks-tab"+num+"-3");
					klone.find("#tasks"+onum+"-3").attr("id","tasks"+num+"-3");
					klone.find("a[href^='#tasks"+onum+"-3']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#tasks"+num+"-3");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

					klone.find("#slide-tasks-tab"+onum+"-4").attr("id","slide-tasks-tab"+num+"-4");
					klone.find("#tasks"+onum+"-4").attr("id","tasks"+num+"-4");
					klone.find("a[href^='#tasks"+onum+"-4']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#tasks"+num+"-4");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

					klone.find("#slide-tasks-tab"+onum+"-5").attr("id","slide-tasks-tab"+num+"-5");
					klone.find("#tasks"+onum+"-5").attr("id","tasks"+num+"-5");
					klone.find("a[href^='#tasks"+onum+"-5']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#tasks"+num+"-5");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					}); 

					klone.find("#slide-tasks-tab"+onum+"-6").attr("id","slide-tasks-tab"+num+"-6");
					klone.find("#tasks"+onum+"-6").attr("id","tasks"+num+"-6");
					klone.find("a[href^='#tasks"+onum+"-6']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#tasks"+num+"-6");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

					klone.find("#slide-tasks-tab"+onum+"-7").attr("id","slide-tasks-tab"+num+"-7");
					klone.find("#tasks"+onum+"-7").attr("id","tasks"+num+"-7");
					klone.find("a[href^='#tasks"+onum+"-7']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#tasks"+num+"-7");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

					klone.find("#slide-tasks-tab"+onum+"-8").attr("id","slide-tasks-tab"+num+"-8");
					klone.find("#tasks"+onum+"-8").attr("id","tasks"+num+"-8");
					klone.find("a[href^='#tasks"+onum+"-8']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#tasks"+num+"-8");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});

					klone.find("#slide-tasks-tab"+onum+"-9").attr("id","slide-tasks-tab"+num+"-9");
					klone.find("#tasks"+onum+"-9").attr("id","tasks"+num+"-9");
					klone.find("a[href^='#tasks"+onum+"-9']").each(function() {
						var anchor = jQuery(this);
						//var name = anchor.attr("href");
						anchor.attr("href", "#tasks"+num+"-9");
						//klone.find("a[name=" + name.substring(1) + "]").attr("name", name.substring(1) + "_1");
					});


			jQuery(".insertdiv").before(klone);
			jQuery("#appendtabt"+num).click();
			//workflow_tasks_slide();

			
		});

		
		
    });

	

	//search
	function search(){
		jQuery( function() {
			jQuery.widget( "custom.catcomplete", jQuery.ui.autocomplete, {
				_create: function() {
					this._super();
					this.widget().menu( "option", "items", "> :not(.ui-autocomplete-category)" );
				},
				_renderMenu: function( ul, items ) {
					var that = this,
					currentCategory = "";
					$.each( items, function( index, item ) {
						var li;
						if ( item.category != currentCategory ) {
							ul.append( "<div class='ui-autocomplete-category'>" + item.category + "</div>" );
							currentCategory = item.category;
						}
						li = that._renderItemData( ul, item );
						if ( item.category ) {
							li.attr( "aria-label", item.category + " : " + item.label );
							return jQuery( "<div class='searchlink-page'>" )
							.append( item.desc +
							"<!--<br><a target='_blank' href='http://google.com'><span style='font-size: 60%;'>Other: " + item.other + "</span></a>-->" )
							.appendTo( li );
						}

						/*  return $( "<li>" )
						.append( "<a>" + item.label + 
						"<br><span style='font-size: 80%;'>Desc: " + item.desc + "</span>" +
						"<br><span style='font-size: 60%;'>Other: " + item.other + "</span></a>" )
						.appendTo( ul );*/

					});
				},
				_resizeMenu: function( ) {
					wrapping_div();
				}
			});

			var data = [
				/* { label: "anders", category: "", other: "other item", desc: "description"},
				{ label: "andreas", category: "", other: "other item1", desc: "description1" },*/
				{ 
					label: "Capitol Title", 
					category: "Companies", 
					desc: "capitoltitle.com" 
				},
				{ 
					label: "Mid-Atlantic Settlement Services - Capitol Hill, DC, a sub...", 
					category: "Companies", 
					desc: "masettlement.com" 
				},
				{ 
					label: "Bailey Glasser.LLP - HQ", 
					category: "Companies", 
					desc: "baileyglasser.com" 
				},
				{ 
					label: "Capital Title Solutions", 
					category: "Companies", 
					desc: "capitaltitlesolutions.com" 
				},
				{ 
					label: "Residential Capital Management", 
					category: "Companies", 
					desc: "resicap.com" 
				},
				{ 
					label: "Residential Capital Management", 
					category: "Companies", 
					desc: "resicap.com" 
				},

				{ 
					label: "Andrew Levy", 
					category: "Contacts", 
					desc: "alevy@capitoltitle.com | Capitol Title | Found in task" 
				},
				{ 
					label: "Stan Goldstein", 
					category: "Contacts", 
					desc: "sgoldstein@capitoltitle.com | Capitol Title" 
				},
				{ 
					label: "Carissa Davis", 
					category: "Contacts", 
					desc: "carissa@capitoltitle.us | Capitol Title" 
				},
				{ 
					label: "John Alford", 
					category: "Contacts", 
					desc: "jdalaw44@gmail.com | Faulknew Capital" 
				},
				{ 
					label: "Candice Lubin", 
					category: "Contacts", 
					desc: "proplogix@resicap.com | Residential Capital" 
				},

				{ 
					label: "Capitol Title", 
					category: "Deals", 
					desc: "Last modified date: Apr 25, 2018" 
				},

				{ 
					label: "Call Andrew (Capitol Title)", 
					category: "Tasks", 
					desc: "Call | Due date: Mar 29, 2018" 
				},
				{ 
					label: "Call Andrew (Capitol Title)", 
					category: "Tasks", 
					desc: "Call | Due date: Mar 29, 2018" 
				},
				{ 
					label: "Call Andrew (Capitol Title)", 
					category: "Tasks", 
					desc: "Call | Due date: Mar 29, 2018" 
				},
				{ 
					label: "Call Andrew (Capitol Title)", 
					category: "Tasks", 
					desc: "Call | Due date: Mar 29, 2018" 
				}


			];

			jQuery( ".biginput" ).catcomplete({
				delay: 0,
				source: data
			});
		});
	}
	
	search();


	jQuery( ".top-tabs li span input" ).keyup(function() {
		var value = jQuery( this ).val();
		jQuery( this ).closest('li').find('.nav-link').text( value );
	}).keyup();

 

	// drag table workflows page
	jQuery( function() {
		jQuery( "#sortable, #sortable1, #sortable2" ).sortable({
			handle: ".profile",
			axis: "y",
			revert: true
		});
		jQuery( "#draggable").draggable({
			connectToSortable: "#sortable, #sortable1, #sortable2",
			revert: "invalid"
		});
		jQuery( ".table-structure tbody, .table-structure tbody tr" ).disableSelection();
	});



}

jQuery(document).ready(function(){
	workflow_tasks_slide();
	tabbing();
	tester = jQuery("#append-t2").clone();
	// admin-menu
	jQuery( ".content-wrapper.admin-page" ).each(function(){
		jQuery('.admin-pages').addClass("open-admin");
	});
	jQuery( ".sidebar .nav .nav-item.admin-pages > .nav-link" ).click(function() {
		jQuery( this ).closest('.admin-pages').toggleClass("open-admin");
	});
});	

function wrapping_div() {	
	$( ".ui-autocomplete-category" ).each(function() {
		var text = $(this).text();
	  $( this).nextUntil( ".ui-autocomplete-category" )
		.wrapAll( "<ul class='cat-items'>" );
		$(this).add($(this).next(".cat-items")).wrapAll("<li class='category'><ul class='category-wrapper'><li></li></ul></li>");
		jQuery(this).parents(".category-wrapper li").append("<a class='new-btn bttn black'> New </a>");
	});

}
function re_call_js() {
	mycharts();
	//workflow_tasks_slide();	
	tabbing();
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