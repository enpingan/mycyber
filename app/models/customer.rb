class Customer < ActiveRecord::Base
  self.table_name = "Customers"

  def change_pwd(customer_id, params)
    user = User.find_by_id(customer_id)

    if !user.blank?
      user.username = params[:username]
      user.password = params[:password]
      user.first_name = params[:first_name]
      user.last_name = params[:last_name]
      user.city = params[:city]
      user.state = params[:state]
      user.number = params[:number]
      user.pemail = params[:pemail]
      user.country = params[:country]

      user.save
    end
  end
end

if Customer.connection.nil?
  Customer.establish_connection "user_panel_#{Rails.env}"
end