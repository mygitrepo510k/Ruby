class UserMatch
  MATCH_PERCENTAGE = 25
  attr_reader :user
  attr :questions, :res, :ids

  def initialize(user)
    @user = user
    @res = {}
  end

  def matched
    unsorted = User.find(ids)
    sorted = ids.inject([]){|res, val| res << unsorted.detect {|u| u.id == val}}
  end

  def ids
    @ids ||= get_user_ids
  end

  private
  def matched_ratio(user)
    val = (own_questions & others_questions(user)).size.to_d / own_questions.size.to_d
    val = (val * 100).to_i
    if val >= MATCH_PERCENTAGE
      res[user.id] = val
    end
  end

  def all_users
    User.active.by_gender(user.gender == 'F' ? 'M' : 'F').includes(:user_questions)
  end

  def own_questions
    @questions ||= user.user_questions.
      joins(:profile_question).
      where("profile_questions.answer_type != 'string'").
      pluck(:profile_question_id, :answer)
  end

  def others_questions(other)
    other.user_questions.
      joins(:profile_question).
      where("profile_questions.answer_type != 'string'").
      pluck(:profile_question_id, :answer)
  end

  def get_user_ids
    arr = []
    if own_questions.size > 0
      all_users.each do |other|
        matched_ratio(other)
      end
      arr = res.sort_by { |a| a[1] }.reverse
      arr = arr.map { |a| a[0] }
    end
    arr
  end
end
