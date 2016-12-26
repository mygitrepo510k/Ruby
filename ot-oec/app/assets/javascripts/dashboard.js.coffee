# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
enable_ajax = true

replace_timestamp = (timestamp) ->
  timestamp.text($.timeago(timestamp.text()))
  timestamp.removeAttr('raw')

replace_timestamps = () ->
  if $('.timeago[raw=true]').length > 0
    $('.timeago[raw=true]').each(() ->
      replace_timestamp($(this)))

bind_like_handler = () ->
  $('a[data-likeable]').unbind( 'click' )
  $('a[data-likeable]').click (e) ->
    link = $(this).children('.like_text')
    e.preventDefault()
    $.post( "/like", $(this).data('likeable') )
      .done((data) ->
        link.text(data.link)
        link.parent().siblings('.like_count_wrapper').find('.like_count').html(data.count)
      )

bind_comment_link_handler = () ->
  $('.comment_link').unbind( 'click' )
  $('.comment_link').click (e) ->
    e.preventDefault()
    post = $(this).parents('.post')
    post.find('.comment_body').focus()

bind_comment_handler = () ->
  $('.comment_body').unbind( 'focus' )
  $('.comment_body').focus(() ->
    comment_box = $(document.activeElement)
    form = comment_box.parent()
    comment_box.unbind( 'keypress' )
    comment_box.keypress( (e) ->
      (e.preventDefault()
      $.ajax( {
        type: 'POST',
        url: form.attr('action'),
        data: form.serialize(),
        success: ( response ) ->
          comment_box.val(null)
          feed = form.closest('.comments').find('.comment_feed')
          feed.append('<div class="comment">' + response.html + '</div>')
          feed.parents('.post').find('.comment_count').html( response.count )
          replace_timestamp(feed.children('.comment').last().find('.timeago'))
          bind_like_handler()
          bind_comment_link_handler()
          bind_comment_delete_handler()
        })
      ) if (e.which == 13)
    )
  )

bind_show_hidden_comment_handler = () ->
  $('a.show-hidden-posts').unbind( 'click' )
  $('a.show-hidden-posts').click (e) ->
    e.preventDefault()
    $(this).siblings('.comment_feed').children().removeClass('hidden')
    $(this).remove()

bind_post_delete_handler = () ->
  $('a.delete-post').unbind( 'click' )
  $('a.delete-post').bind('ajax:success', (e, data, status, xhr) ->
    if xhr.responseJSON.status == true
      post = $(this).parents('.post')
      post.fadeOut('fast', () ->
        post.remove())
  )

bind_comment_delete_handler = () ->
  $('a.delete-comment').unbind( 'click' )
  $('a.delete-comment').bind('ajax:success', (e, data, status, xhr) ->
    if xhr.responseJSON.status == true
      comment = $(this).parents('.comment')
      comment.fadeOut('fast', () ->
        comment.remove())
  )

show_post_edit = (post) ->
  post.find('.post_edit_form').show()
  post.find('.post_body').hide()

hide_post_edit = (post) ->
  post.find('.post_edit_form').hide()
  post.find('.post_body').show()

bind_post_edit_handler = () ->
  $('a[data-edit-post]').unbind( 'click' )
  $('a[data-edit-post]').click (e) ->
    e.preventDefault()
    post = $(this).closest('.post')
    show_post_edit(post)

bind_post_edit_submit_handler = () ->
  $('a[data-post-edit-submit]').unbind( 'click' )
  $('a[data-post-edit-submit]').click (e) ->
    e.preventDefault()
    form = $(this).closest('form').unbind('ajax:success')
    form.bind 'ajax:success', (e, data, status, xhr) ->
      if xhr.responseJSON.success == true
        form.find('textarea').val(xhr.responseJSON.body)
        body = form.parent().siblings('.post_body').text(xhr.responseJSON.body)
        hide_post_edit(form.closest('.post'))
    form.submit()

bind_post_edit_cancel_handler = () ->
  $('a[data-post-edit-cancel]').unbind( 'click' )
  $('a[data-post-edit-cancel]').click (e) ->
    e.preventDefault()
    post = $(this).closest('.post')
    hide_post_edit(post)

set_like_count_tooltip = () ->
  $('.like_count_wrapper').each (i, elem) ->
    if $(elem).prop('title')
      $(elem).tooltipster()

bind_handlers = () ->
  bind_like_handler()
  bind_comment_handler()
  bind_comment_link_handler()
  bind_show_hidden_comment_handler()
  bind_post_delete_handler()
  bind_comment_delete_handler()
  bind_post_edit_handler()
  bind_post_edit_submit_handler()
  bind_post_edit_cancel_handler()
  set_like_count_tooltip()

reset_file_upload_fields = () ->
  $('.add-picture a.filepicker').show()
  $('.add-picture .filename').remove()
  $('#post_filepicker_url').val('')
  $('#post_s3_key').val('')

$ ->
  Shadowbox.init()
  $(document).ajaxSuccess( () ->
    Shadowbox.clearCache()
    Shadowbox.setup())

  if $('#new_post').length > 0
    $('#new_post').on('ajax:success', (e, data, status, xhr) ->
      $('#post_body').val(null)
      $('.post_feed').prepend $.parseJSON(xhr.responseText).html
      post = $('.post').first().hide()
      replace_timestamp(post.find('.timeago'))
      post.fadeIn('slow')

      reset_file_upload_fields()
      bind_handlers()
	  ).on "ajax:error", (e, xhr, status, error) ->
	    $('.post_feed').prepend "<p>ERROR</p>"

  replace_timestamps()

  loading_posts = false
  if $('a.load-more-posts').length > 0
    $('a.load-more-posts').on 'inview', (e, visible) ->
      return if loading_posts or not visible
      loading_posts = true
 
      $.ajax({
        url: $(this).attr('href'),
        dataType: 'script',
        complete: ( data, status, xhr ) ->
          loading_posts = false
          replace_timestamps()
          bind_handlers()
      })

  post_box = $('#submit_post').first()
  post_box.click((e) ->
    e.preventDefault() if ($('#post_body').val().length == 0) && ($('#post_filepicker_url').val() == ''))

  search_button = $('#search_posts').first()
  search_button.click((e) ->
    e.preventDefault() if ($('#search_terms').val().length == 0))

  bind_handlers()

  $("[data-toggle='tooltip']").tooltip()
  return
