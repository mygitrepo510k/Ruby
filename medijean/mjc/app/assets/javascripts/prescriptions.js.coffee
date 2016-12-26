$(document).ready ->
  # prescription symptom others field script
  $("#prescription_symptom").change ->
    if $("#prescription_symptom").val() is "Other"
      $("#prescription_symptom").after "<input id='prescription_other_symptom' class='input-medium' type='text' size='30' name='prescription[symptom]'>"
    else
      $("#prescription_other_symptom").remove()
  # prescription quantity others field script
  $("#prescription_dosage").change ->
    if $("#prescription_dosage").val() is "Other"
      $("#prescription_dosage").after "<div id='prescription_dosage_other_div' ><input id='prescription_other_dosage' class='input-medium' type='text' size='30' name='prescription[other_dosage]'> g/day </div>"
    else
      $("#prescription_dosage_other_div").remove()