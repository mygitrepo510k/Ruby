def init
  super
  sections.place(:validation).before(:subclasses)
  # puts sections.inspect

end