require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe FamiliesController do

  # This should return the minimal set of attributes required to create a valid
  # Family. As you add validations to Family, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "user" => "" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # FamiliesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all families as @families" do
      family = Family.create! valid_attributes
      get :index, {}, valid_session
      assigns(:families).should eq([family])
    end
  end

  describe "GET show" do
    it "assigns the requested family as @family" do
      family = Family.create! valid_attributes
      get :show, {:id => family.to_param}, valid_session
      assigns(:family).should eq(family)
    end
  end

  describe "GET new" do
    it "assigns a new family as @family" do
      get :new, {}, valid_session
      assigns(:family).should be_a_new(Family)
    end
  end

  describe "GET edit" do
    it "assigns the requested family as @family" do
      family = Family.create! valid_attributes
      get :edit, {:id => family.to_param}, valid_session
      assigns(:family).should eq(family)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Family" do
        expect {
          post :create, {:family => valid_attributes}, valid_session
        }.to change(Family, :count).by(1)
      end

      it "assigns a newly created family as @family" do
        post :create, {:family => valid_attributes}, valid_session
        assigns(:family).should be_a(Family)
        assigns(:family).should be_persisted
      end

      it "redirects to the created family" do
        post :create, {:family => valid_attributes}, valid_session
        response.should redirect_to(Family.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved family as @family" do
        # Trigger the behavior that occurs when invalid params are submitted
        Family.any_instance.stub(:save).and_return(false)
        post :create, {:family => { "user" => "invalid value" }}, valid_session
        assigns(:family).should be_a_new(Family)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Family.any_instance.stub(:save).and_return(false)
        post :create, {:family => { "user" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested family" do
        family = Family.create! valid_attributes
        # Assuming there are no other families in the database, this
        # specifies that the Family created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Family.any_instance.should_receive(:update_attributes).with({ "user" => "" })
        put :update, {:id => family.to_param, :family => { "user" => "" }}, valid_session
      end

      it "assigns the requested family as @family" do
        family = Family.create! valid_attributes
        put :update, {:id => family.to_param, :family => valid_attributes}, valid_session
        assigns(:family).should eq(family)
      end

      it "redirects to the family" do
        family = Family.create! valid_attributes
        put :update, {:id => family.to_param, :family => valid_attributes}, valid_session
        response.should redirect_to(family)
      end
    end

    describe "with invalid params" do
      it "assigns the family as @family" do
        family = Family.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Family.any_instance.stub(:save).and_return(false)
        put :update, {:id => family.to_param, :family => { "user" => "invalid value" }}, valid_session
        assigns(:family).should eq(family)
      end

      it "re-renders the 'edit' template" do
        family = Family.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Family.any_instance.stub(:save).and_return(false)
        put :update, {:id => family.to_param, :family => { "user" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested family" do
      family = Family.create! valid_attributes
      expect {
        delete :destroy, {:id => family.to_param}, valid_session
      }.to change(Family, :count).by(-1)
    end

    it "redirects to the families list" do
      family = Family.create! valid_attributes
      delete :destroy, {:id => family.to_param}, valid_session
      response.should redirect_to(families_url)
    end
  end

end
