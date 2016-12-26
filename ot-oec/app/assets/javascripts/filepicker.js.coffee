filepicker.setKey('AMII1eCkRTGLpytp1Pp4Bz')

$('.filepicker').click (e) ->
    e.preventDefault()
    filepicker.pickAndStore(
      {
        mimetypes: ['image/*', 'video/*'],
        container: 'window',
        services:['COMPUTER', 'URL'],
      },
      {
        location: 'S3',
        path: '/uploads/post/',
        access: 'public'
      },
      (files) ->
        file = files[0]
        name = file.filename.replace(/\s+/g, '-')
        $('.filepicker_full').val(file.url + '+' + name)
        if $('.filepicker_thumb')
          filepicker.convert file, {width: 50, height: 50}, (converted) ->
            $('.filepicker_thumb').val(converted.url)
        $('.add-picture').toggleClass('on', !!$('#post_post_link').val())
        $('.add-picture a.filepicker').hide()
        $('.add-picture').append("<div class='filename'>" + name + "</div>")
      (FPError) ->
        $('.add-picture').toggleClass('on', !!$('#post_post_link').val())
    )

append_url_in_hidden_field = (file) ->
  name = file.filename.replace(/\s+/g, '-')
  url = file.url + '+' + name

  name_input = '<input id="content__name" name="content[][name]" type="hidden" value="' + name + '">'
  url_input = '<input id="content__filepicker_url" name="content[][filepicker_url]" type="hidden" value="' + url + '">'

  $('#file_names').append('<li>' + name + '</li>')
  $('#field_groups').append(name_input)
  $('#field_groups').append(url_input)

$('.filepicker_multi').click (e) ->
    e.preventDefault()
    filepicker.pickMultiple(
      {
        mimetypes: ['image/*', 'video/*', 'audio/*', 'text/*',
                    'application/pdf', 'application/msword', 'application/vnd.ms-excel', 'application/vnd.ms-powerpoint'],
        container: 'window',
        services:['COMPUTER', 'URL'],
      },
      (files) ->
        append_url_in_hidden_field file for file in files
      (FPError) ->
        alert('something went wrong with file upload')
    )
