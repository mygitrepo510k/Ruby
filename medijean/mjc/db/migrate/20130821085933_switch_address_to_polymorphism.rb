class SwitchAddressToPolymorphism < ActiveRecord::Migration
  def up
    change_table :addresses do |t|
      t.references :addressable, :polymorphic => true
    end

    [Doctor, Clinic, Profile].each do |klass|
      klass.select('address_id, id').all.each do |klass_instance|
        address = Address.where(id: klass_instance.address_id).first
        address.update_attributes(addressable_id: klass_instance.id, addressable_type: klass.to_s) if address
      end
    end

    remove_column :doctors, :address_id
    remove_column :clinics, :address_id
    remove_column :profiles, :address_id
  end

  def down
    add_column :doctors, :address_id, :integer
    add_column :clinics, :address_id, :integer
    add_column :profiles, :address_id, :integer

    Address.select('id, addressable_type, addressable_id').all.each do |address|
      target = address.addressable_type.constantize.where(id: address.addressable_id).first
      target.update_attribute(:address_id, address.id) if target
    end

    change_table :addresses do |t|
      t.remove_references :addressable, :polymorphic => true
    end
  end
end
