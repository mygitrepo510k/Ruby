require 'test_helper'

class UsersDecoratorTest < ActionView::TestCase
  setup do
    @base = FactoryGirl.build_stubbed(:user, user_profile: FactoryGirl.build(:user_profile))
    @decorated = UserDecorator.new(@base, view)
  end
  it "has a profile title" do
    @decorated.profile_title.must_equal "Le title"
  end
  it "has a profile description" do
    @decorated.profile_description.must_equal "I am a very nice individual"
  end
  it "has a looking_for attribute" do
    @decorated.looking_for.must_equal "Cats"
  end
end
