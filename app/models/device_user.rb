class DeviceUser < ActiveRecord::Base
  self.table_name = "Device_Users"

  def self.search(device_name)
    ret = DeviceUser.where(:device_name => device_name)

    return ret
  end

end

# if DeviceUser.connection.nil?
#   establish_connection "user_panel_#{Rails.env}"
# end