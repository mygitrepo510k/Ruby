$(document).ready ->
  # searchig from patient views
  if $('form').attr('action') == '/doctors/search' and  $('form').attr('data-eco-template') == 'patient_doctors_search'
      $('#find_doctor_search_btn').click (e) ->
          e.preventDefault()
          name_search_field = $("#find_doctor_name_search_field").val()
          $.ajax '/doctors/search',
              type: 'GET'
              dataType: 'json'
              data: { search: name_search_field }
              error: (jqXHR, textStatus, errorThrown) ->
                  alert textStatus
              success: (data, textStatus, jqXHR) ->
                  if data.success == true
                      $(".find_doctor_response_count").html data.records_found + " Results found for <strong> &#147; " + name_search_field + " &#147; </strong>"
                      $(".find_doctor_query_response").html JST["templates/doctors/patient_doctors_search"](doctors : data.data.doctors)
  if $("#reason").val() is "Other"
    $("#reason").after "&nbsp;&nbsp;<input id='profile_reason_description' class='input-medium' type='text' size='30' name='profile[reason_description]'>"
  else
    $("#profile_reason_description").remove()
  $("#reason").change ->
    if $("#reason").val() is "Other"
      $("#reason").after "&nbsp;&nbsp;<input id='profile_reason_description' class='input-medium' type='text' size='30' name='reason_description'>"
    else
      $("#profile_reason_description").remove()
  $('#new_user').submit ->
    if ($('#accept_agreement').length > 0) && !$('#accept_agreement').is(':checked')
      return false