class ChangeFieldsInPaymentsLogger < ActiveRecord::Migration
  def change
    change_column :payments_loggers, :body, :text
    change_column :payments_loggers, :message, :text
  end
end
