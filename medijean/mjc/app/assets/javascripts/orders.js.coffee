jQuery ->
  if typeof Stripe != 'undefined'
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
    order.setupForm()
    $('#card_number').payment('formatCardNumber')
    $('#card_code').payment('formatCardCVC');
    $('.shipping_address').hide()
    $('#shipping_check').click ->
      $('.shipping_address').toggle()
      if($('#shipping_check').is(':checked'))
        $('#shipping_address_street').attr('required',false)
        $('#shipping_address_unit').attr('required',false)
        $('#shipping_address_city').attr('required',false)
        $('#shipping_address_postal_code').attr('required',false)
      else
        $('#shipping_address_street').attr('required',true)
        $('#shipping_address_unit').attr('required',true)
        $('#shipping_address_city').attr('required',true)
        $('#shipping_address_postal_code').attr('required',true)
    $('#card_number').keyup ->
      $('#visa').css('opacity','0.2')
      $('#amex').css('opacity','0.2')
      $('#mastercard').css('opacity','0.2')
      card = $.payment.cardType($('#card_number').val())
      $('#' + card).css('opacity','1')

order =
  setupForm: ->
    $('#payment-form').submit ->
      $('input[type=submit]').attr('disabled',true)
      order.processCard()
      false

  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
      name: $('#name').val()
      address_line1: $('#address_street').val()
      address_line2: $('#address_unit').val()
      address_city: $('#address_city').val()
      address_state: $('#address_province').val()
      address_zip: $('#address_postal_code').val()
      address_country: 'Canada'
    Stripe.createToken(card, order.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#stripe_card_token').val(response.id)
      $('#payment-form')[0].submit()
    else
      if response.error.message == "Your card number is incorrect." || response.error.message == "This card number looks invalid"
        $('.card-code-error').text('')
        $('.card-expiration-error').text('')
        $('.card-number-error').text(response.error.message)
      else if response.error.message == "Your card's security code is invalid."
        $('.card-expiration-error').text('')
        $('.card-number-error').text('')
        $('.card-code-error').text(response.error.message)
      else if response.error.message == "Your card's expiration month is invalid."
        $('.card-number-error').text('')
        $('.card-code-error').text('')
        $('.card-expiration-error').text(response.error.message)
      else
        $('.card-number-error').text('')
        $('.card-code-error').text('')
        $('.card-expiration-error').text('')
        $('.payment-errors').text(response.error.message)
      $('input[type=submit]').attr('disabled',false)