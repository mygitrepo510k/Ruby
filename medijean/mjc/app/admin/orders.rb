ActiveAdmin.register Order do
  filter :status, :as => :select, :collection => Hash[Order::STATUS.map{ |k, v| [k.to_s.humanize, v] }]
  config.sort_order = "created_at_desc"
  actions :all, :except => [:new, :edit]
  # menu :priority => 1, :label => "Orders"

  index do 
    column :id
    column :processed_by
    column :status                      
    column :created_at
    column :user
    column :shipping_address
    default_actions           
  end

  form do |f|
    f.inputs "Order Details" do

      status_keys = Order::STATUS.keys
      payment_status = Order::PAYMENT_STATUS.keys

      f.input :total
      f.input :status, :as => :select, :collection => status_keys
      f.input :placed_at
      f.input :sub_total
      f.input :taxname
      f.input :payment_status, :as => :select, :collection => payment_status
      f.input :tax
      f.input :shipping_address
      f.input :prescription
      f.input :user
    end
    f.actions
  end

  controller do
    def show
      @order = Order.find(params[:id])
      @versions = @order.versions 
      @order = @order.versions[params[:version].to_i].reify if params[:version]
      show!
    end
    def update 
      @order = Order.update(params[:id], params[:order])
      if @order.save

        if @order.status?(:processing)
           # mailer call goes here
        end

        flash[:notice] = "Order successfully updated"

        UserMailer.update_order_email(@order.user).deliver

        redirect_to admin_order_path(@order.id)
      else
        flash[:notice] = "Order couldn't be updated #{@order.errors.full_messages.join(",")}"
        redirect_to admin_order_path(@order.id)
      end
    end

  end

  sidebar :versions, :partial => "layouts/version", :only => :show
  sidebar :tracking_number, :partial => "layouts/tracking_number_input", :only => :show, :if => proc {Order.find(params[:id]).status?(:processing)}

  member_action :history do
    @order = Order.find(params[:id])
    @versions = @order.versions
    render "layouts/history"
  end

  action_item :only => :show do
    link_to('History', :action => "history")
  end

  member_action :process_order do
    @order = Order.find(params[:id])
    @order.status = :processing
    @order.processed_by = current_admin_user

    if @order.save
      flash[:notice] = "Processing order"
    else
      flash[:error] = "Couldn't start processing: #{@order.errors.full_messages.join(",")}"
    end
    redirect_to :action => :show
  end

  action_item :only => :show do
    @order = Order.find(params[:id])
    if @order.status?(:placed)
      link_to('Start Processing', :action => "process_order")
    end
  end
end
