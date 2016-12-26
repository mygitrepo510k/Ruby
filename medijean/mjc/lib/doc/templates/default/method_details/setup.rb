def init
  super
  if sections.name.nil?
    sections.first.place(:validation).before(:source)
  end
end