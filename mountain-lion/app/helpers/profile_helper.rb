module ProfileHelper
  def popover_title
    "Wait..."
  end
  def popover_msg
    "You didn't fill out all the required questions.  Please go back and answer them completely."
  end
  def build_js_validation(user)
    ##compose javascript conditional(s) for required profile sections
    @cs_arr = []
    @cond_req_str = "".html_safe
    @cond_ptr_var = "collapse_arr=[]\n".html_safe
    user.required_profile_sections.each do |ps|
       ps.profile_questions.includes(:profile_answers).each do |pq| 
         @cs_arr << build_js_field_test(pq)
         @cond_req_str = @cond_req_str + "cond#{pq.id}" + "||"
       end
       @cond_ptr_var = @cond_ptr_var + %Q{collapse_arr.push $("##{ps.slug}")\n}.html_safe
    end
    @cond_var = "".html_safe
    @cs_arr.each do |c|
      @cond_var = @cond_var+%Q{  #{c}\n}.html_safe
    end
    @cond_var = @cond_var.html_safe
    
    ##compose javascript conditional(s) for optional profile sections
    user.optional_profile_sections.each do |ps|
      @cond_ptr_var = @cond_ptr_var + %Q{collapse_arr.push $("##{ps.slug}")\n}.html_safe
    end
    compare_cond_str =
    %Q{#{@cond_ptr_var}} +
    %Q{collapse_arr_ptr = 0\n} + 
    %Q{showPopover = ->\n} +
    %Q{  $(this).popover "show"\n} +
    %Q{hidePopover = ->\n} +
    %Q{  $(this).popover "hide"\n} +
    %Q{popover_display = $("#popover-display").popover\n} +
    %Q{  trigger: "manual"\n} +
    %Q{  placement: "left"\n} +
    %Q{popover_warning = $("[rel=next-popover]").popover\n} +
    %Q{  trigger: "manual"\n} +
    %Q{  placement: "left"\n} +
    %Q{$("#my-description").on "mouseenter mouseleave", (e) ->\n} +
    %Q{  cond_pt = $("#user_user_profile_attributes_title").val()==""\n} +
    %Q{  cond_pd = $("#user_user_profile_attributes_about_me").val()==""\n} +
    %Q{  cond_lf = $("#user_user_profile_attributes_looking_for").val()==""\n} +
    %Q{#{@cond_var}} +
    %Q{  if (!(#{@cond_req_str}cond_pt||cond_pd||cond_lf))\n} + 
    %Q{    popover_display.popover 'hide'\n} + 
    %Q{  else\n} +
    %Q{    popover_display.popover 'show'\n} +
    %Q{$(".optional").on "change keyup", (e) ->\n} +
    %Q{  cond_pt = $("#user_user_profile_attributes_title").val()==""\n} +
    %Q{  cond_pd = $("#user_user_profile_attributes_about_me").val()==""\n} +
    %Q{  cond_lf = $("#user_user_profile_attributes_looking_for").val()==""\n} +
    %Q{#{@cond_var}} +
    %Q{  if (!(#{@cond_req_str}cond_pt||cond_pd||cond_lf))\n} +
    %Q{    popover_display.popover 'hide'\n} + 
    %Q{  else\n} +
    %Q{    popover_display.popover 'show'\n} + 
    %Q{$("#next-submit").on "click", (e) ->\n} +
    %Q{  cond_pt = $("#user_user_profile_attributes_title").val()==""\n} +
    %Q{  cond_pd = $("#user_user_profile_attributes_about_me").val()==""\n} +
    %Q{  cond_lf = $("#user_user_profile_attributes_looking_for").val()==""\n} +
    %Q{#{@cond_var}}+
    %Q{  if (#{@cond_req_str}cond_pt||cond_pd||cond_lf)\n} +
    %Q{    e.preventDefault()\n}+
    %Q{    $('#skip-upload').hide()\n} +
    %Q{    popover_display.popover 'show'\n} + 
    %Q{  else\n} + 
    %Q{    popover_display.popover 'hide'\n} + 
    %Q{    $("#edit_user_#{user.id}").submit ->\n} +
    %Q{      valuesToSubmit = $(this).serialize()\n} +
    %Q{      $.ajax(\n} +
    %Q{        url: $(this).attr("action")\n} +
    %Q{        type: 'POST'\n} +
    %Q{        data: valuesToSubmit\n} +
    %Q{        dataType: "JSON"\n} +
    %Q{      ).success (json) ->\n} +
    %Q{      false\n} +
    %Q{    if collapse_arr_ptr<collapse_arr.length-1\n} +
    %Q{      collapse_arr[collapse_arr_ptr].collapse('hide')\n} +
    %Q{      collapse_arr_ptr = collapse_arr_ptr+1\n} +
    %Q{      collapse_arr[collapse_arr_ptr].collapse('show')\n} +
    %Q{    else\n} +
    %Q{      document.location.href = "#{new_user_user_photo_path(user)}"\n} + 
    %Q{    $('#skip-upload').show()\n}
    compare_cond_str.html_safe
  end
  def build_js_field_test(profile_question)
    case profile_question.answer_type
    when "string"
      %Q{cond#{profile_question.id}=$("input:radio[name='user_questions[#{profile_question.id}]']").val()==""}.html_safe
    when "select_list"
      %Q{cond#{profile_question.id}=$("#user_questions_#{profile_question.id}").val()==""}.html_safe
    when "radio_group"
      %Q{cond#{profile_question.id}=$("input:radio[name='user_questions[#{profile_question.id}]']:checked").length==0}.html_safe
    when "check_box"
      %Q{cond#{profile_question.id}=$("input[name='user_questions[#{profile_question.id}][]']:checked").length==0}.html_safe
    else
      nil
    end
  end
  def dynamic_field(profile_question, value = nil)
    ret = ""
    case profile_question.answer_type
    when "string"
      ret = get_string_answer(profile_question, value)
    when "select_list"
      ret = select_tag("user_questions[#{profile_question.id}]", options_for_select(profile_question.profile_answers.map {|pa| [pa.answer, pa.id]}, selected: (value.to_i if value), prompt: "Please choose an answer"))
    when "check_box"
      ret = get_checkbox_answer(profile_question, value)
    when "radio_group"
      profile_question.profile_answers.each do |answer|
        ret << content_tag(:label, class: "radio inline") do
          radio_button_tag("user_questions[#{profile_question.id}]", answer.id, answer.id == value.to_i) + " " + answer.answer
        end
      end
      ret
    else
      nil
    end
    ret.html_safe
  end

  def get_answer_value(question, user)
    user.user_questions.includes(:profile_question).where(profile_question_id: question.id).try(:first).try(:answer)
  end

  def get_string_answer(profile_question, value)
    text_field_tag("user_questions[#{profile_question.id}]", value)
  end

  def get_checkbox_answer(profile_question, value)
      ret = ""
      value = value.split(',').map {|val| val.to_i} if value
      profile_question.profile_answers.each do |answer|
        ret << content_tag(:label, class: "checkbox inline") do
          check_box_tag("user_questions[#{profile_question.id}][]", answer.id, (value.include?(answer.id) if value)) +" " + answer.answer
        end
      end
      ret
  end

  def unread_counter(count)
    content_tag(:span, count.to_s, class: "badge badge-important") if (count || 0)  > 0
  end

  def rating_image(user, size = nil, align = nil)
    title = "This user has a #{number_to_word(user.rating)} star rating!"
    image_tag("profile-#{user.rating}-star#{ '-small' if size == 'small' }.png", title: title, align: align)
  end

  def rating_div(rating)
    render "users/rating_#{rating}"
  end
  private
  def number_to_word(num)
    numbers = { 1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five" }
    numbers[num]
  end
end
