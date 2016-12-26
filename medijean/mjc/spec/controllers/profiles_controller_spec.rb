require 'spec_helper'

describe ProfilesController do
  before do 
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe 'PUT #update' do
    let(:profile)   {@user.profile.nil? ? @user.build_profile : @user.profile}
    context 'when profile was updated' do
      it "redirect to the settings profile show" do
        redirect_to settings_profile_path
      end
    end

    context 'when profile was not updated' do
      it "redirect :back" do
        redirect_to :back
      end
    end
    
  end
  
  describe 'POST #account' do
    
    context 'when user account was updated' do
      it "redirect to the settings profile show" do
        redirect_to settings_account_path
      end
    end

    context 'when user account was not updated' do
      it "redirect :back" do
        redirect_to :back
      end
    end
  end

  describe 'POST #notification' do
    let(:notification)   {@user.notification_settings.nil? ? @user.build_notification_settings : @user.notification_settings}
    
    context 'when notification was updated' do
      it "redirect to the settings profile show" do
        redirect_to settings_account_path
      end
    end

    context 'when notification was not updated' do
      it "redirect :back" do
        redirect_to :back
      end
    end
  end
end
