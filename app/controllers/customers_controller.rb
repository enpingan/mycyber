class CustomersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find_by_id(current_user.id)
    @customer = Customer.find_by_id(current_user.id)

    if !flash["retry"].nil? || !flash["retry"].blank?
      @retry = "retry"
      @retry_params = flash[:retry_params]
    end

    if @retry_params.blank?
      @retry_params = Customer.new
    end
  end

  def modify
    # customer = Customer.where(:username=>current_user.username).where(:password=>params[:op][:hid])
    customer = Customer.find_by_id(current_user.id)

    if !customer.blank?
      customer.username = params[:username]
      customer.password = params[:password]
      customer.first_name = params[:first_name]
      customer.last_name = params[:last_name]
      customer.city = params[:city]
      customer.state = params[:state]
      customer.number = params[:number]
      customer.pemail = params[:pemail]
      customer.country = params[:country]

      if customer.save
        # user = User.where(:username=>current_user.username)
        # user = User.find_by_id(current_user.id)

        # if !user.blank?
        #   user.username = params[:username]
        #   user.password = params[:password]
        #   user.first_name = params[:first_name]
        #   user.last_name = params[:last_name]
        #   user.city = params[:city]
        #   user.state = params[:state]
        #   user.number = params[:number]
        #   user.pemail = params[:pemail]
        #   user.country = params[:country]

        #   # user.save
        # end
        customer.change_pwd(current_user.id, params)
      end

      # sign_in( current_user, :bypass=>true)
      redirect_to customers_url, notice: 'Customer Info was updated successfully.'

      # render json:nil, status: :ok      
    else
      # user = User.where(:username=>current_user.username)
      redirect_to customers_url, flash:{retry:"retry", retry_params: params}
      # render json:nil, status: :ok
    end

  end


end