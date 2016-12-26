class AddFieldsToPaymentsLogger < ActiveRecord::Migration
  def change
    add_column :payments_loggers, :body, :string
  end
end
