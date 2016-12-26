# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

populate_contents = () ->
  params = {}
  month = $('#content_month_selector').val()
  option = $('#content_option_selector').val()
  if month
    params['month'] = $('#content_month_selector').val()
  if option
    params['option'] = $('#content_option_selector').val()

  url = '/content_load' + '?' + $.param(params)

  $.get url, (resp) ->
    $('#main_contents_list').html( resp.html )

$('#content_month_selector').change () ->
  populate_contents()

$('#content_option_selector').change () ->
  populate_contents()

$('#content_files_button').click () ->
  params = {}
  params['files'] = true

  url = '/content_load' + '?' + $.param(params)

  $.get url, (resp) ->
    $('#main_contents_list').html( resp.html )

$ ->
  if $('#main_contents_list').length > 0
    $.get '/content_load', ( data ) ->
      $('#main_contents_list').html( data.html )
