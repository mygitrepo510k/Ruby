(1..14).each do |num|
  ActiveRecord::Base.transaction do
    CSV.foreach(Rails.root + "db/cities_#{num}.tsv", col_sep: "\t") do |row|
      City.create!(geoname_id: row[0], name: row[2], latitude: row[4].to_f, longitude: row[5].to_f, country_code: row[8], state_code: row[10])
    end
  end
  puts "Done with #{num}0000"
end
