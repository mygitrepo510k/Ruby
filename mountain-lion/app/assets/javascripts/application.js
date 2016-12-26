//= require jquery.min
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.ui.all
//= require jquery.Jcrop.min
//= require jquery.placeholder.min
//= require bootstrap
//= require bootstrap-wysihtml5
//= require welcome
//= require jquery.jcarousel.min
//= require fancybox
//= require shared/flashes/noty-config

$(document).ready(function() {
  $('input').placeholder();
});
$.fn.riseUp = function()   { $(this).show("slide", { direction: "down" }, 2000); }
$.fn.riseDown = function() { $(this).hide("slide", { direction: "down" }, 2000); }
