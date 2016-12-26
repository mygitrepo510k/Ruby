class Lounge
  attr_reader :gender, :staff

  def initialize(gender, staff = false)
    @gender = gender
    @staff = staff
  end
  def feed
    get_feed
  end
  private
  def get_feed
    if staff
      UserActivity.staff
    else
      required = gender == 'M' ? 'F' : 'M'
      UserActivity.by_gender(required)
    end
  end
  def get_upcoming_birthdays
    User.
      where("to_char(date_of_birth,'MMDD')::int between ? and ?",
            Date.today.strftime('%m%d').to_i,
            (Date.today + 10).strftime('%m%d').to_i).
      pluck(:id, :gender, :date_of_birth)
  end
end
