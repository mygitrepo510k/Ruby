class RatingCalculator
  def initialize(user)
    @user = user
  end
  def recalculate_rating
    if user.premium
      rating = 5
    else
      rating = [active, questions, photos].select { |x| x == true }.size + 1
    end

    if rating != user.rating
      user.update_attribute(:rating, rating)
      return rating
    else
      return nil
    end
  end
  private
  attr_reader :user
  def questions
    user.user_questions.count.to_f / ProfileQuestion.visible.count.to_f >= 0.5
  end
  def photos
    user.user_photos.count > 0
  end
  def active
    user.activation_state == 'active'
  end
end
