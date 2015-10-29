class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  self.table_name = "Users"
end

# if User.connection.nil?
#   User.establish_connection "user_panel_#{Rails.env}"
# end