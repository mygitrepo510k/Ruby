ActiveRecord::Base.transaction do
  CSV.foreach(Rails.root + 'db/admin_codes.tsv', col_sep: "\t") do |row|
    State.create(country_code: row[0].split('.')[0], state_code: row[0].split('.')[1], name: row[2], geoname_id: row[3].to_i)
  end
end


