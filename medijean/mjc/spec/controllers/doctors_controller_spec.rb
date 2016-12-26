require 'spec_helper'

describe DoctorsController do
  before do
    @clinic  = FactoryGirl.attributes_for(:clinic)
    @address = FactoryGirl.attributes_for(:address)
    @user    = FactoryGirl.create(:doctor_user)
    sign_in(@user)
  end

  describe "PUT #update" do
    before do
      @doctor  = FactoryGirl.create(:active_doctor)
    end

    context "with valid data" do
      it "returns redirect on update" do
        put :update, id: @doctor.id, doctor: @doctor.attributes.except('id', 'created_at', 'updated_at', 'clinic_id', 'status', 'gender').merge({ clinic: @clinic.merge({address_attributes: @address})}),
           doctor_phone: {p1: '123', p2: '456', p3: '7890'}, clinic_phone: {p1: '012', p2: '345', p3: '6789'}
        response.should redirect_to(doctors_dashboard_path)
      end

      it "creates new clinic and clinic.address" do
        expect do
          put :update, id: @doctor.id, doctor: @doctor.attributes.except('id', 'created_at', 'updated_at', 'clinic_id', 'status', 'gender').merge({ clinic: @clinic.merge({address_attributes: @address})}),
            doctor_phone: {p1: '123', p2: '456', p3: '7890'}, clinic_phone: {p1: '012', p2: '345', p3: '6789'}
        end.to change(Clinic, :count).by(1) and change(Address, :count).by(1)
      end
    end

    context "with invalid data" do
      before { @invalid_attributes = @doctor.attributes.except('id', 'created_at', 'updated_at', 'clinic_id', 'status', 'gender') }
      before { @invalid_attributes[:physician_id] = nil }

      it "renders edit" do
        put :update, id: @doctor.id, doctor: @invalid_attributes.merge({ clinic: @clinic.merge({address_attributes: @address})}),
                     doctor_phone: {p1: '123', p2: '456', p3: '7890'}, clinic_phone: {p1: '012', p2: '345', p3: '6789'}
        response.should render_template :edit
      end
    end
  end

  describe "POST #create" do
    before { @invalid_attributes = FactoryGirl.attributes_for(:doctor) }
    before { @invalid_attributes.delete(:physician_id) }

    context "with invalid data" do
      before { post :create, doctor: @invalid_attributes.merge({ clinic: @clinic.merge({address_attributes: @address})}),
               doctor_phone: {p1: '123', p2: '456', p3: '7890'}, clinic_phone: {p1: '012', p2: '345', p3: '6789'} }

      it "fails" do
        response.should render_template :new
      end
    end

    context "with valid data" do
      before { post :create, doctor: FactoryGirl.attributes_for(:doctor).merge({ clinic: @clinic.merge({address_attributes: @address})}),
               doctor_phone: {p1: '123', p2: '456', p3: '7890'}, clinic_phone: {p1: '012', p2: '345', p3: '6789'} }

      it "redirect on create" do
        response.should redirect_to(doctors_dashboard_path)
      end
    end
  end

end
