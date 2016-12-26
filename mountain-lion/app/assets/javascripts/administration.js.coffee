$ ->
  $('a#select-all').click ->
    $(':checkbox').prop('checked', true)
  $('a#unselect-all').click ->
    $(':checkbox').prop('checked', false)
