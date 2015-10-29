# import db tables from adcp
User.establish_connection "user_panel_#{Rails.env}"
Device.establish_connection "user_panel_#{Rails.env}"
Ticket.establish_connection "user_panel_#{Rails.env}"
Dnote.establish_connection "user_panel_#{Rails.env}"
Comment.establish_connection "user_panel_#{Rails.env}"
DeviceUser.establish_connection "user_panel_#{Rails.env}"
Customer.establish_connection "user_panel_#{Rails.env}"