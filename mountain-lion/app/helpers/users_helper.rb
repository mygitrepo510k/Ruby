module UsersHelper
  def like_button_text(user, visitor = current_user)
    if UserLike.where(user_id: user.id, visitor_id: visitor.id).present?
      content_tag(:i, nil, class: "icon-minus icon-white") + " " + I18n.t('links.unlike')
    else
      content_tag(:i, nil, class: "icon-plus icon-white") + " " + I18n.t('links.like')
    end
  end
  def user_photo(klass, id, size, user = current_user)
    if user.profile_photo(user == current_user).present?
      image_tag(user.profile_photo(user == current_user).image.url(size.to_sym), class: klass, id: "i_#{id}")
    else
      image_tag("nopic-#{user.gender.downcase}-#{size}.jpg", class: klass, id: id)
    end
  end
  def user_email_photo(klass, id, size, user)
    if user.profile_photo(false).present?
      image_tag(user.profile_photo(false).image.url(size.to_sym), class: klass, id: "i_#{id}")
    else
      image_tag("nopic-#{user.gender.downcase}-#{size}.jpg", class: klass, id: id)
    end
  end
  def age(dob)
    age = numeric_age(dob)
    "#{age} Years Old"
  end

  def numeric_age(dob)
    today = Date.today
    age = today.year - dob.year
    age -= 1 if dob.strftime("%m%d").to_i > today.strftime("%m%d").to_i
    age
  end
  def get_user_activity(activity, created_at)
    "#{I18n.t('activity_types.' + activity)} #{time_ago_in_words(created_at)} ago"
  end
end
