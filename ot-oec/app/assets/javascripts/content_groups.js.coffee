# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

bind_delete_handler = () ->
  $('a[data-remove-fieldset]').unbind( 'click' )
  $('a[data-remove-fieldset]').click (e) ->
    e.preventDefault()
    $(this).closest('li').remove()

$ ->
  $('a[data-add-fields]').unbind( 'click' )
  $('a[data-add-fields]').click (e) ->
    e.preventDefault()
    fields = $('#field_groups')
    url = '/contents/new' + '?type=' + $(this).data('add-fields')
    $.get( url , (resp) ->
      fields.append('<li>' + resp.html + '</li>')
      bind_delete_handler())

  $('a[data-video-player]').click (e) ->
    e.preventDefault()
    $('#video-player').html($(this).data('video-player'))
