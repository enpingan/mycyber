class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery
  
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def after_sign_in_path_for(resource)
    # redirect_to "http://my.cyberadvance.com" 
    # redirect_to "/admin"
    # session[:my_account] = current_user.my_account
    # profile_url
    dashboard_url
  end

end
