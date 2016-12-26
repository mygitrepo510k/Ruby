namespace :hyedating do

  desc 'Sends emails to all users that had profile views in the last week'
  task views_email: :environment do
    if Time.now.friday?
      visits = ProfileVisit.where("updated_at >= ?", Date.today - 20.days)
      user_ids = visits.uniq.pluck(:user_id)
      users = User.active.where(id: user_ids)
      users.find_each do |user|
        if user.id != -1 || !user.setting.views_email
          visitors = visits.where(user_id: user.id).where('viewer_id != -1').uniq.pluck(:viewer_id)
          users = User.active.where(id: visitors).take(10)
          UserMailer.profile_views_email(user, users).deliver
        end
      end
    end
  end

  desc 'Sends emails to all users with the newly registered users'
  task new_users_email: :environment do
    if Time.now.wednesday?
      users = User.active.joins(:setting).where('user_settings.new_users_email = true')
      users.find_each do |user|
        new_users_email(user)
      end
    end
  end
end

def new_users_email(user)
  if user.id != -1
    gender = user.gender == 'M' ? 'F' : 'M'
    new_members = User.
      by_gender(gender).
      active.
      where('created_at >= ?', Date.today - 7.days).
      near(user, 40000).
      order('distance').
      order('rating desc').
      take(10)
    if new_members.count > 0
      UserMailer.new_users_email(user, new_members).deliver
    end
  end
end
