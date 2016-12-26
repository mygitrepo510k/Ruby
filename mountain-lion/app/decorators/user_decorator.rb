class UserDecorator < Draper::Decorator
  delegate_all
  delegate :current_page, :total_pages, :limit_value

  def lounge_photo
    h.link_to h.user_path(object.username), class: 'pull-left' do
      thumbnail
    end
  end

  def seo_photo
    h.link_to h.signup_path(who: object.username), class: 'pull-left' do
      thumbnail
    end
  end

  def lounge_username_and_age
    h.link_to h.user_path(object.username) do
      username_and_age
    end
  end

  def seo_username_and_age
    h.link_to h.signup_path(who: object.username) do
      username_and_age
    end
  end

  def location
    "#{object.city.capitalize}, #{object.country}"
  end

  def profile_title
    h.content_tag(:h4, class: 'text-error') do
      object.user_profile.title
    end
  end

  def profile_description
    object.user_profile.about_me
  end

  def looking_for
    object.user_profile.looking_for
  end

  def thumbnail
    h.user_photo('media-object img-polaroid', '100', 'thumb', object)
  end
  private

  def username_and_age
    h.content_tag(:strong) do
      "#{object.username}, #{h.age(object.date_of_birth)}"
    end
  end
end
