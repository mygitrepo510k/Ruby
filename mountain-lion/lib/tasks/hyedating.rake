namespace :hyedating do

  desc 'loads the countries from country gem into the db'
  task load_countries: :environment do
    Country.destroy_all
    ActiveRecord::Base.transaction do
      ISO3166::Country.all.each do |country|
        Country.create!(name: country[0], code: country[1])
      end
    end
  end

  desc 'loads the states from the maxmind csv'
  task load_states: :environment do
    filename = Rails.env.staging? ? 'db/regions_staging.csv' : 'db/regions.csv'
    State.destroy_all
    ActiveRecord::Base.transaction do
      CSV.foreach(Rails.root + filename ) do |row|
        State.create!(country_code: row[0].upcase, state_code: row[1].upcase, name: row[2])
      end
    end
  end

  desc 'loads the cities from the maxmind csv'
  task load_cities: :environment do
    filename = Rails.env.staging? ? 'db/cities_staging.csv' : 'db/cities.csv'
    City.destroy_all
      cities = []
      if Rails.env.staging?
        CSV.foreach(Rails.root + filename, encoding: 'latin-1') do |row|
          cities << City.new(country_code: row[0].upcase, name: row[2], state_code: row[3].upcase,
                      latitude: row[4].to_f, longitude: row[5].to_f)
        end
      end
    ActiveRecord::Base.transaction do
      City.import cities
    end
  end
end
