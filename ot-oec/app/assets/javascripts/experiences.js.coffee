# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $('#add_followers_popup').length > 0
    popup = $('#add_followers_popup')
    popup.dialog({ autoOpen: false })
    popup.show()

    $('a[data-add-followers]').unbind('click')
    $('a[data-add-followers]').click (e) ->
      e.preventDefault()
      $('#add_followers_popup').dialog('open')

  if $('.experience_survey').length > 0
    $('.submit_content_group').click( (e) ->
      e.preventDefault()
      exp_form = $('.experience_survey').find('form:first')
      $.ajax({
        type: 'POST',
        url: exp_form.attr('action'),
        data: exp_form.serialize(),
        success: ( response ) ->
          if response.success == true
            $('#new_content_group').submit()
      })
    )

  $('#experience_created_for').bind 'railsAutocomplete.select', (event, data) ->
    $('#intake').html(null)
    $.ajax({
      type: 'GET',
      url: ['/admin/users/', data.item.id, '/get_intake'].join(''),
      success: ( response ) ->
       	$('#intake').append(response.html)
    })

