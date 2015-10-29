class Comment < ActiveRecord::Base  
  self.table_name = "Comments"
end

# if Comment.connection.nil?
#   Comment.establish_connection "user_panel_#{Rails.env}"
# end