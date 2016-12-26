class OrdersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :except => [:create]
  
  def index
    # @orders automatically set to Product.accessible_by(current_ability) from load_and_authorize_resource
    @orders=current_user.orders.page(params[:page]).per(10)
  end

  def show
    # @order is automatically set from load_and_authorize_resource
    @order = Order.find(params[:id])
    # @medicine = Medicine.find(@prescription.medicine.id)
    # @line_item = LineItem.find(@medicine.id)
    # # Assuming shipping to be $50. Because we don't have shipping values specified.
    # @shipping = 50
  end

  def new
    # @TODO params priscription id
    @prescription = Prescription.find(params[:prescription_id])
    @total_price = (30 * @prescription.dosage.quantity) * @prescription.medicine.price
    @taxes = @total_price * Order::DEFAULT_TAX_RATE
    @total_amount = @total_price + @taxes
    if @prescription.status == :prescribed
      @prescription.status = 'active'
      @prescription.save!
    end
  end

  # This action renders the view of order completion in which details of the order are mentioned
  # along with the confirmation to the patient.
  def complete

  end

  def create
    payment_provider=PaymentProvider.new
    @prescription=Prescription.find(params[:prescription_id])
    @total_price = (30 * @prescription.dosage.quantity) * @prescription.medicine.price
    @taxes = @total_price * Order::DEFAULT_TAX_RATE
    @total_amount = @total_price + @taxes
    @plan_amount = @total_amount.to_f * 100
    @order= Order.new(params[:order])

    if params[:shipping_check]
      @shipping_address = Address.new(params[:address])
    else
      @shipping_address = Address.new(params[:shipping_address])
    end

    if @shipping_address.valid?
      @order.update_attributes(:prescription_id=>@prescription.id,:user_id=>current_user.id, :placed_at=>DateTime.now, :status=> :placed,:sub_total=>@total_price,:total=>@total_amount,:shipping_address=>@shipping_address, :tax=>@taxes)
      @line_item = @order.line_items.new(:quantity=>@prescription.dosage.quantity,:unit=>@prescription.medicine.unit,:price=>@prescription.medicine.price * @prescription.dosage.quantity,:medicine_id=>@prescription.medicine.id)
      if @order.save
        @line_item.save
        UserMailer.complete_order_email(@order.user).deliver
        if params[:save_payment]
           if current_user.payment_profile.present?
             customer_response = payment_provider.retrieve_profile(current_user.payment_profile.customer_id)
           else
             customer_response = payment_provider.create_profile(params[:stripe_card_token],current_user.email,current_user.email)
             @payment_profile = PaymentProfile.new(params[:paymentprofile])
             @payment_profile.update_attributes(:user_id=> current_user.id,:customer_id=>customer_response.customer_id)
             @payment_profile.save
           end
           charge_response = payment_provider.charge(@plan_amount.to_i, current_user.email, {:customer_id=>customer_response.customer_id})
        else
          charge_response = payment_provider.charge(@plan_amount.to_i,current_user.email,{:token=>params[:stripe_card_token]})
        end
        @payment=Payment.new(:order_id=>@order.id,:charge_id=>charge_response.charge_id, :operation=> :charge,:success=>charge_response.success,:message=>charge_response.message)
        @payment.save
        @prescription.update_attribute(:status,:ordered)
        @prescription.save
        respond_to do |format|
          format.html{ redirect_to complete_orders_path }
          format.json {render json: @order, status: :success}
        end
      else
        @order_errors = @order.errors.full_messages
        respond_to do |format|
          format.html{ render :new }
          format.json {render json: @order, status: :failure}
        end
      end
    else
      @address_errors = @shipping_address.errors.full_messages
      render :new
    end
  end

end