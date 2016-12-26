# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  user_email = $("#user_email").val()
  health_card_number = $("#user_profile_attributes_health_card_number").val()
  $("#btn_patient").click ->
    if $("#user_email").val() is user_email and $("#user_profile_attributes_health_card_number").val() is health_card_number
      false
    else
      true