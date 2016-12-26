def create_and_sign_in(resource_name=:user)
  resource = FactoryGirl.create(resource_name)
  sign_in(resource)
  resource
end

def setup_abilities
  @ability = Object.new
  @ability.extend(CanCan::Ability)
  @controller.stub(:current_ability).and_return(@ability)
end