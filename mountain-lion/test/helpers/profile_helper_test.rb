require 'test_helper'

describe ProfileHelper do
  let(:profile_answer) { Struct.new(:id, :answer) }
  let(:answers) {[profile_answer.new(1, "first"), profile_answer.new(2, "second")]}
  describe "#dynamic_field" do
    describe "#string" do
      let(:question) { FactoryGirl.build_stubbed(:string_profile_question) }
      it "creates a text field input tag if the profile_question's answer type is string" do
        dynamic_field(question).must_equal text_field_tag("user_questions[#{question.id}]")
      end
      it "creates a text field input tag if the profile_question's answer type is string and assigns the value to it" do
        dynamic_field(question, "Some value").must_equal text_field_tag("user_questions[#{question.id}]", "Some value")
      end
    end
    describe "#select_list" do
      let(:question) { FactoryGirl.build_stubbed(:profile_question, answer_type: "select_list")}
      it "creates a select list if the entry param is select_list" do
        question.stub :profile_answers, answers do
          dynamic_field(question).must_equal select_tag("user_questions[#{question.id}]", options_for_select(question.profile_answers.map {|pa| [pa.answer, pa.id]}, prompt: "Please choose an answer"))
        end
      end
      it "creates a select list if the entry param is select_list and selects a value" do
        question.stub :profile_answers, answers do
          dynamic_field(question, 1).must_equal select_tag("user_questions[#{question.id}]", options_for_select(question.profile_answers.map {|pa| [pa.answer, pa.id]}, selected: 1, prompt: "Please choose an answer"))
        end
      end
    end
    describe "#check_box" do
      let(:question) { FactoryGirl.build_stubbed(:profile_question, answer_type: "check_box")}
      it "creates a check_box input tag if the entry param is check_box" do
        question.stub :profile_answers, answers do
          dynamic_field(question).must_equal "<label class=\"checkbox inline\"><input id=\"user_questions_#{question.id}_\" name=\"user_questions[#{question.id}][]\" type=\"checkbox\" value=\"1\" /> first</label><label class=\"checkbox inline\"><input id=\"user_questions_#{question.id}_\" name=\"user_questions[#{question.id}][]\" type=\"checkbox\" value=\"2\" /> second</label>"
        end
      end
      it "creates a check_box input tag if the entry param is check_box and sets values if present" do
        question.stub :profile_answers, answers do
          dynamic_field(question, "1").must_equal "<label class=\"checkbox inline\"><input checked=\"checked\" id=\"user_questions_#{question.id}_\" name=\"user_questions[#{question.id}][]\" type=\"checkbox\" value=\"1\" /> first</label><label class=\"checkbox inline\"><input id=\"user_questions_#{question.id}_\" name=\"user_questions[#{question.id}][]\" type=\"checkbox\" value=\"2\" /> second</label>"
        end
      end
    end
    describe "#radio_group" do
      let(:question) { FactoryGirl.build_stubbed(:profile_question, answer_type: "radio_group")}
      it "creates a radio_group input tag if the answer type is radio_group" do
        question.stub :profile_answers, answers do
        dynamic_field(question).must_equal "<label class=\"radio inline\"><input id=\"user_questions_#{question.id}_1\" name=\"user_questions[#{question.id}]\" type=\"radio\" value=\"1\" /> first</label><label class=\"radio inline\"><input id=\"user_questions_#{question.id}_2\" name=\"user_questions[#{question.id}]\" type=\"radio\" value=\"2\" /> second</label>"
        end
      end
      it "creates a radio_group input tag if the answer type is radio_group and selects if a value is entered" do
        question.stub :profile_answers, answers do
          dynamic_field(question, 1).must_equal "<label class=\"radio inline\"><input checked=\"checked\" id=\"user_questions_#{question.id}_1\" name=\"user_questions[#{question.id}]\" type=\"radio\" value=\"1\" /> first</label><label class=\"radio inline\"><input id=\"user_questions_#{question.id}_2\" name=\"user_questions[#{question.id}]\" type=\"radio\" value=\"2\" /> second</label>"
        end
      end
    end
  end
  describe "#unread_counter" do
    it "produces the right html for a given number" do
      unread_counter(5).must_equal '<span class="badge badge-important">5</span>'
    end
    it "doesn't display when the count is zero" do
      unread_counter(0).must_be_nil
    end
    it "doesn't display when the count is nil" do
      unread_counter(nil).must_be_nil
    end
  end
end
