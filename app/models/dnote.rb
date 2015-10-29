class Dnote < ActiveRecord::Base
  self.table_name = "Dnotes"

  def self.search(filter_item, device_name)
  
    if !filter_item.nil? && !device_name.nil?
      tmp = filter_item

      dnotes = Dnote.where(:device_name=>device_name).where("request_order LIKE ? OR device_status LIKE ?", "%#{filter_item}%", "%#{filter_item}%")
    else
      dnotes = Dnote.where(:device_name=>device_name)
    end
  
    return dnotes
  end
end

# if Dnote.connection.nil?
#   Dnote.establish_connection "user_panel_#{Rails.env}"
# end