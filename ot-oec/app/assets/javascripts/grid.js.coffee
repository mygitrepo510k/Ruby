# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

load_grid = (type) ->
  $.get 'grid/' + type, (resp) ->
    $('#grid_table').html( resp.html )

    if type == 'experiences'
      $('.experience').each (index, elem) ->
        $(elem).tooltipster({ content: $(elem).find('.tooltip_wrapper').html() })
        $('.student_portrait').tooltipster()

$('#grid_type_selector').change () ->
  load_grid($(this).val().toLowerCase())

$ ->
  if $('#grid_table').length > 0
    load_grid('experiences')

