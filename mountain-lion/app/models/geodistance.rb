class Geodistance
  include Math
  attr_reader :from, :to
  RADIUS = 6371
  def initialize(from, to)
    @from = { latitude: to_rad(from[:latitude]), longitude: to_rad(from[:longitude]) }
    @to = { latitude: to_rad(to[:latitude]), longitude: to_rad(to[:longitude]) }
  end

  def miles_distance
    (distance / 1.54).to_i
  end

  def distance
    # ACOS(SIN(lat1)*SIN(lat2)+COS(lat1)*COS(lat2)*COS(lon2-lon1))*6371
    acos(sin(from[:latitude]) * sin(to[:latitude]) +
         cos(from[:latitude]) * cos(to[:latitude]) *
         cos(to[:longitude] - from[:longitude])) * RADIUS
  end

  private
  def to_rad(degree)
    degree / 180 * Math::PI
  end
end
