class Device < ActiveRecord::Base
  self.table_name = "Devices"

  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000)
    end while Model.where(id: self.id).exists?
  end

  def self.search(filter_item, username)
  
    if !filter_item.blank? && !filter_item[:name].nil?
      tmp = filter_item

      devices = Device.where("name LIKE ? AND location LIKE ? AND device_type LIKE ? AND public_ip LIKE ? AND private_ip LIKE ?", "%#{tmp[:name]}%", "%#{tmp[:location]}%", "%#{tmp[:device_type]}%", "%#{tmp[:public_ip]}%", "%#{tmp[:private_ip]}%")
    else
      devices = Device.where(:owner=>username)
    end
  
    return devices
  end

  def self.saction(params)

    if !params.blank? && !params[:device_name].nil?
      tmp = Device.find_by_name(params[:device_name])

      dnote = Dnote.new(:device_id=>tmp.id,:device_name=>tmp.name,:device_status=>tmp.general_status,:is_checked=>false,:request_order=>params[:request])
      dnote.save

      tmp.detail = "updated"
      tmp.save
    end

  end

  def self.device_sortable(column, direction)
    case column
    when "Name"
      col = "name "
    when "Type"
      col = "device_type "
    when "Location"
      col = "location "
    when "Public IP"
      col = "public_ip "
    when "Private IP"
      col = "private_ip "
    when "Start Time"
      col = "created_at "
    else
      col = " "
    end

    return col + direction
  end

  def self.to_thdindex(sort_item)
    case sort_item
    when "Name"
      col = 0
    when "Type"
      col = 1
    when "Location"
      col = 2
    when "Public IP"
      col = 3
    when "Private IP"
      col = 4
    when "Start Time"
      col = 5
    else
      col = 6
    end

    return col
  end

end

# if Device.connection.nil?
#   Device.establish_connection "user_panel_#{Rails.env}"
# end