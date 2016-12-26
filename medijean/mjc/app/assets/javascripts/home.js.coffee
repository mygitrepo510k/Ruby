# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  
  # Sign up validation
  $(".sign_up_form").submit ->
    email = $("#user_email").val()
    password = $("#user_password").val()
    confirm_password = $("#user_password_confirmation").val()
    if email is ""
      alert "Email can't be blank."
      return false
    if password is ""
      alert "Password can't be blank."
      return false
    #unless password is confirm_password
      #alert "Password does not match with the confirmation password."
      #false

  # Home page Lower button to set focus on email field
  $("#hp-signup-LWR-btn").click ->
    $(":input", "#new_user").not(":button, :submit, :reset, :hidden").val ""
    $("#user_email").focus()