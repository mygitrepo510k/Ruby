class Gender
  def self.all
    [{gender: "M", name: I18n.t('models.gender.male')},{gender: "F", name: I18n.t('models.gender.female')}]
  end
end
