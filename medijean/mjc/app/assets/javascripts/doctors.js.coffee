$ ->
  # patinets searchig from doctors views
  if $('form').attr('action') == '/doctors/search_patients' and  $('form').attr('data-eco-template') == 'patients'
    $('#doctor_search_patients_btn').click (e) ->
      e.preventDefault()
      name_search_field = $("#find_patient_name_search_field").val()
      $.ajax '/doctors/search_patients',
        type: 'GET'
        dataType: 'json'
        data: { search: name_search_field }
        error: (jqXHR, textStatus, errorThrown) ->
          alert textStatus
        success: (data, textStatus, jqXHR) ->
          if data.success == true
            $(".find_patients_response_count").html data.records_found + " Results found for <strong> &#147; " + name_search_field + " &#147; </strong>"
            $(".find_patients_query_response").html JST["templates/patients/doctors_patients_search"](patients : data.data.patients)
            $("tr.invite-patient").on
              mouseenter: ->
                $(this).find(".btn-invite-patient").stop().fadeTo("fast", 1).find(".btn-invite-patient").addClass("show-btn").removeClass "hide-btn"
              mouseleave: ->
                $(this).find(".btn-invite-patient").stop().fadeTo "fast", 0
  $('.container').on 'focusout', '.edit_doctor:first #doctor_physician_id', ->
    if $(this).val().length > 0
      $.ajax
        type: 'GET'
        url: '/doctors/' + $(this).val() + '/edit'
        dataType: 'script'

  user_email = $("#user_email").val()
  $("#btn_doctor").click ->
    if $("#user_email").val() is user_email
      false
    else
      true