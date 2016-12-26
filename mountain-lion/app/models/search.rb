class Search
  attr_reader :gender, :params

  def initialize(gender, params, options = {})
    @gender = gender.upcase == 'M' ? 'F' : 'M'
    @params = params
    begin
      @from = { latitude: options[:latitude], longitude: options[:longitude] }
    rescue
    end
  end

  def users
    result = if params.is_a? Hash
               User.active.by_gender(gender).where(id: advanced_user_ids)
             elsif params.is_a? String
               User.where(id: simple_user_ids)
             end
    result.order(rating: :desc) if result
  end
  private
  def match_question(question)
    params.each do |k,v|
      if question.profile_question_id == k.to_i && v & question.get_answer_ids
        return true
      end
    end
    false
  end

  def advanced_user_ids
    UserQuestion.includes(:profile_question)
                .map { |uq| uq.user_id if match_question(uq) }
  end
  def simple_user_ids
    distances = User.by_gender(gender).active.where('latitude is not null and longitude is not null').pluck(:id, :latitude, :longitude).select() do |data|
      begin
       distance = Geodistance.new(@from, { latitude: data[1], longitude: data[2] }).miles_distance
       if params == '1000+' || distance <= params.to_i
         data[0]
       end
      rescue
        # :)
      end
    end
    distances.reject(&:nil?)
  end
end
