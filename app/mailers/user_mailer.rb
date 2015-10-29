class UserMailer < ApplicationMailer
  def created_email(created_info, user_info)
    @url  = 'http://my.cyberadvance.com/'
    @created_info = created_info
    @user_info = user_info
    # mail(to: "support@cyberadvance.com", subject: 'The ticket was created successfully')
    # mail(to: user_info.email, subject: 'The ticket was created successfully')
  end 

  def cdevice_email(cdevice_info, user_info)
    @url  = 'http://my.cyberadvance.com/'
    @cdevice_info = cdevice_info
    @user_info = user_info
    # mail(to: "support@cyberadvance.com", subject: 'The Device was created successfully')
    # mail(to: user_info.email, subject: 'The Device was created successfully')
  end 

  def comment_email(comment_info)
    @url  = 'http://my.cyberadvance.com/'
    @comment_info = comment_info
    # mail(to: "support@cyberadvance.com", subject: 'The Device was created successfully')
    # mail(to: comment_info.user_email, subject: 'The Comment was created successfully')
  end 
end
