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
//= require colorbox-rails
//= require bootstrap
//= require twitter/bootstrap
//= require_tree .

var logied_in = false

$(function(){
	
	$("select.choosen-select").chosen();
	//$("select.choosen-sub-select").chosen();

  $('input[type="radio"]').customInput();

  $('[data-validate]').blur(function() {
		$this = $(this);
		console.log($this.val());
		$.get($this.data('validate'), {
				sc_name: $this.val()
		}).success(function() {
			console.log('success');
			$this.removeClass('field_with_errors');
		}).error(function() {
			alert('This value is not available');
			$this.addClass('field_with_errors');
			$this.focuss();
		});
	});

});

function isNumber(text){
  var numbers=/^[0-9]+$/;
  if(text.match(numbers))
    return true
  else
    return false
  
  return false
}