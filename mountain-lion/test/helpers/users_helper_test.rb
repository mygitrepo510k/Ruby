require 'test_helper'

describe UsersHelper do
  include Rails.application.routes.url_helpers
  describe "#decorate_user" do
    it "calls a UserDecorator" do
      model = User.new
      UserDecorator.expects(:new).with(model, self)
      decorate_user(model)
    end
  end
  describe "#like_button_text" do
    it "returns like message if the user is not in the like list" do
      model = User.new
      current_user = mock
      current_user.stubs(:id).returns(1)
      like_button_text(model, current_user).must_equal "<i class=\"icon-plus icon-white\"></i> " + I18n.t('links.like')
    end
    it "returns unlike if the user is already on the like list" do
      model = User.new
      current_user = mock
      current_user.stubs(:id).returns(1)
      UserLike.stubs(:where).returns(true)
      like_button_text(model, current_user).must_equal "<i class=\"icon-minus icon-white\"></i> " + I18n.t('links.unlike')
    end
  end
end
