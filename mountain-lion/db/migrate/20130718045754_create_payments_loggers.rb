class CreatePaymentsLoggers < ActiveRecord::Migration
  def change
    create_table :payments_loggers do |t|
      t.references :user, index: true
      t.text :message

      t.timestamps
    end
  end
end
