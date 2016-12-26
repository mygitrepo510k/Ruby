module ApplicationHelper
  def growl_messages(flash)
    flash.reduce('') do |messages, (key, value)|
      messages << %(noty({text: "#{value}", type: "#{key}"}); \n)
    end
  end
  def online_users
    random_num = [*18..27].sample
    session[:random_users] ||= random_num
    User.current_users.count + session[:random_users]
  end
  def separator
    "  |  "
  end
  def format_date(date)
    val = date
    begin
      val = date.strftime('%m/%d/%Y')
    rescue
    end
    val
  end
  def gender_select_options(selected = nil)
    options_for_select([['Male', 'M'], ['Female', 'F']], selected: selected)
  end
  def user_cache_key(user)
    "user/#{user.id}/#{user.gender}"
  end
  def states_select(country, selected = nil)
    states = State.where(country_code: Country.find_country_by_name(country).alpha2).order('name ASC')
    options_for_select(states.map {|s| [s.name, s.id] }, selected: selected, prompt: 'Choose State or County')
  end
  def city_select(country, state_id, selected = nil)
    state = State.find(state_id)
    cities = City.where(country_code: Country.find_country_by_name(country).alpha2, state_code: state.state_code).order('name ASC')
    options_for_select(cities.map {|s| [s.name, s.id] }, selected: selected, prompt: 'Choose a City')
  end
end
