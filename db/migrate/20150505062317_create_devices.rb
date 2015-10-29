class CreateDevices < ActiveRecord::Migration
  def change
    create_table :Devices do |t|
      t.string :name
      t.string :device_type
      t.string :location
      t.string :public_ip
      t.string :private_ip

      t.timestamps null: false
    end
  end
end
