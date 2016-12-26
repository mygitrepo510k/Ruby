if Rails.env.development? && defined?(Footnotes)
  Footnotes.run! # first of all

  # ... other init code
end