Thread.new do
  # system("rackup faye.ru -s thin -E development") if Rails.env == "development"
  system("rackup faye.ru -s thin -E production") if Rails.env == "production"
end