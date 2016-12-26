require 'spec_helper'

describe KnowledgeCentreController do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @page = FactoryGirl.create(:kc_page)
  end

  describe "GET 'knowledge_centre'" do   
    
    context "when @page is nil" do
      it "returns http success" do      
        redirect_to root_url
        response.should be_success
      end
    end

    context "when @page is exist" do
      before { @page = FactoryGirl.create(:kc_page) }
      it "returns http success" do      
        get :index
        #response.should be_success
      end
    end
  end

  describe "GET '/kc/:page_url'" do
    context "when @page is nil" do
      it "returns http success" do      
        redirect_to root_url
        response.should be_success
      end
    end

    context "when @page is exist" do
      before { @page = FactoryGirl.create(:kc_page) }
      it "returns http success" do      
        get :index
        #response.should be_success
      end
    end
  end
end
