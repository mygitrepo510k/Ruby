# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  displayMessage = false
  $(window).bind "beforeunload", ->
    
    #the custom message for page unload doesn't work on Firefox
    if displayMessage
      message = "This page is asking you to confirm that you want to leave - data you have entered may not be saved."
      message

  $(".page-content .row input").change ->
    displayMessage = true

  $(".page-content .last-row input").click ->
    if displayMessage is false 
      return false
    displayMessage = false
    return true

  
  $("#change_password_button").click ->
    field_blank = true
    displayMessage = false
    $(".password-input-errors-row").children().remove()
    if $("#user_old_password").val() is ""
      $(".password-input-errors-row").append "<label class=\"password-error\">Please input old password</label>"
      field_blank = true
    else
      field_blank = false
    if $("#user_new_password").val() is ""
      $(".password-input-errors-row").append "<label class=\"password-error\">Please input new password</label>"
      field_blank = true
    else
      field_blank = false
    if $("#user_confirm_new_password").val() is ""
      $(".password-input-errors-row").append "<label class=\"password-error\">Please input confirm password</label>"
      field_blank = true
    else
      field_blank = false
    if field_blank is false      
      $("#change_account_form").attr "action", "/profiles/change_password"
      $("#change_account_form").submit()
      false
    else
      displayMessage = false
      false

  $("#change_password").click ->
    $(".password-box").hide()
    $(".change-password-box").show()

  $("#cloase_change_password").click ->
    $(".password-box").show()
    $(".change-password-box").hide()
