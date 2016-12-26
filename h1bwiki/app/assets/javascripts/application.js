// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.tokeninput
//= require parsley
//= require parsley.extend
//= require jquery-ui
//= require autocomplete-rails
//= require_tree .

var isLoged = false;

function setHeight(){
	var height = $(window).height();
	var top_height = $("div.navbar-fixed-top").outerHeight();
	var footer_height = $("div.footer").outerHeight();
	$("div.main-row").css("min-height", height-top_height-footer_height);		
	return true;
}

$(window).resize(function() {
	setHeight();	
});


$(function(){	
//	$('#authors_names_0').addClass("parsley-validated");
//	$('#authors_names_0').attr("data-mincheck", "1");

	$("label.radio label").removeClass("checked");
	$("label.first-label").addClass('checked');

	$("#skill_input_box").tokenInput("/skills.json", {
    crossDomain: false,
    prePopulate: $("#skill_input_box").data("pre"),
    propertyToSearch: "name",
    theme: "facebook"
  });
  setHeight();
  var pre_action = $("#job_post_form").attr("action");	
	$('#btn_post_preview').click(function(){		
		var preview = "/preview";
		var re = new RegExp("\/[a-z]*_[a-z]*[^\/]", "i");		
		var controller = pre_action.match(re);
		$("#job_post_form input[name='_method']").val("post")
		$("#job_post_form").attr("target", "_blink");
		$("#job_post_form").attr("action", controller+preview);
	});
	$('#btn_post_create').click(function(){
		$("#job_post_form input[name='_method']").val("put")
		$("#job_post_form").attr("target", "_self");
		$("#job_post_form").attr("action", pre_action);
	});

	$("a.contact-button").each(function(){		
		$(this).click(function(){
			$("#recipients_hiddenfield").val($(this).attr("type"));
			$("#conversation_subject").val($(this).attr("rel"));			
		})
	});
});






/*	
	$("a.view-details").each(function(){
		$(this).click(function(){
			var sibl_item = $(this).siblings(0);
			if(sibl_item.height() == 40){
				sibl_item.animate({height:"80px"})
			}else{
				sibl_item.animate({height:"40px"})
			}			
		});
	});
*/