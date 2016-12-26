# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  #$("input.billing_name").change ->
  #  $("#billing_name").val $("input.billing_name").eq(0).val() + "-" + $("input.billing_name").eq(1).val()

  $(".card_number").change ->  
    card_num = $("#card_number").val()
    
    console.log(Stripe.card.cardType(card_num));
    if Stripe.card.cardType(card_num) is "Visa"
      $("img.visa").css "opacity", "1"
    else
      $("img.visa").css "opacity", "0.2"
    
    if Stripe.card.cardType(card_num) is "MasterCard"
      $("img.master").css "opacity", "1"
    else
      $("img.master").css "opacity", "0.2"

    if Stripe.card.cardType(card_num) is "American Express"
      $("img.american").css "opacity", "1"
    else
      $("img.american").css "opacity", "0.2"

  $("#payment_form").submit (event) ->
    $form = $(this)
    if $("#first_name").val() is ""
      $form.find(".payment-errors").text "Please input First Name"
      $("#first_name").focus()
      return false
    if $("#last_name").val() is ""
      $form.find(".payment-errors").text "Please input Last Name"
      $("#last_name").focus()
      return false
    if $("#card_number").val().length < 10
      $form.find(".payment-errors").text "Please input Card number"
      $("#c_num1").focus()
      return false
    if $("#cvc_number").val() is ""
      $form.find(".payment-errors").text "Please input CVC or CSV"
      $("#cvc_number").focus()
      return false
    
    # Disable the submit button to prevent repeated clicks
    $form.find("input.save_change").prop "disabled", true
    Stripe.createToken $form, stripeResponseHandler
    
    # Prevent the form from submitting with the default action
    false

  stripeResponseHandler = (status, response) ->
    $form = $("#payment_form")
    if response.error
      
      # Show the errors on the form
      $form.find(".payment-errors").text response.error.message
      $form.find("input.save_change").prop "disabled", false
    else
      
      # token contains id, last4, and card type
      token = response.id
      
      # Insert the token into the form so it gets submitted to the server
      $form.append $("<input type=\"hidden\" name=\"stripe_token\" />").val(token)
      
      # and submit
      $form.get(0).submit()