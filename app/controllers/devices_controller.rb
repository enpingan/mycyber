require 'will_paginate/array'

class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    # @devices = Device.all
    @devices = Device.where(:owner=>current_user.username)
    
    # sort
    @thd = []

    if !params[:sort_item].nil?
      did = Device.to_thdindex(params[:sort_item])

      if params[:direction] != ""
        if params[:direction] == "desc"
          @thd[did] = "_d"
        else
          @thd[did] = "_a"
        end
      end
    end
    
    if !params[:sort_item].nil?
      str_order = Device.device_sortable(params[:sort_item], params[:direction])
    end

    # filter
    if !params[:name].nil?
      @filter_params = params
    end

    # saction
    if !params[:device_name].nil?
      Device.saction(params)
    end

    # show filtered and sorted
    if str_order.nil?
      @devices = Device.search(@filter_params, current_user.username).order(:updated_at=>:desc)
    else
      @devices = Device.search(@filter_params, current_user.username).order(str_order).order(:updated_at=>:desc)
    end

    # paginate
    if params["device_rows"].nil? || params["device_rows"].blank?
      @rows = 5
    else 
      @rows = params["device_rows"]
    end

    if params[:page].nil?
      @page_number = 1
    else
      @page_number = params[:page]
    end
    
    @devices = @devices.paginate(:page => params[:page], :per_page => @rows.to_i)

    tmp = Dnote.where(:is_checked=>"0")
    @dnote_count = tmp.count

    if @dnote_count > 0
      @dnote_content = tmp.last.request_order
    end

  end

  # def filter
  #   redirect_to devices_url, flash:{filter_str:params}
  # end

  # def setrows
  #   redirect_to devices_url, flash:{rows:params["device_rows"]}
  # end

  # def saction
  #   tmp = params
  #   redirect_to devices_url, flash:{saction:tmp}
  # end

  # def tickets
  #   tmp = params[:device_id]
  #   @tickets = Ticket.where(:device_id=>tmp).order(:updated_at=>:desc).paginate(:page=>params[:page], :per_page=>5)      
  #   @comments = Comment.all

  #   # Paginate
  #   if params["ticket_rows"].nil?
  #     @rows = 5
  #   else 
  #     @rows = params["ticket_rows"]
  #   end
  #   # setrows
  #   if params[:page].nil?
  #     @page_number = 1
  #   else
  #     @page_number = params[:page]
  #   end

  #   # show page number
  #   if params[:page].nil?
  #     @page_number = 1
  #   else
  #     @page_number = params[:page]
  #   end

  #   @ticket_count = @tickets.count
  # end

  def security
    @dname = params[:device_name]
    
    # Paginate
    if params[:security_rows].nil?
      @rows = 5
    else 
      @rows = params[:security_rows]
    end

    # delete a request from security table
    if !params[:dnote_id].nil?
      Dnote.find_by_id(params[:dnote_id]).delete
    end

    # show page
    if params[:page].nil?
      @page_number = 1
    else
      @page_number = params[:page]
    end

    @filter_word = params[:filter_word]
    @dnotes = Dnote.search(params[:filter_word], @dname).order(:updated_at=>:desc)
    number_entries = @dnotes.count
    @dnotes = @dnotes.paginate(:page=>params[:page], :per_page=>@rows, :total_entries => number_entries> 25 ? 25 : number_entries )
    # fresh_when @dnotes
  end

  def cancel_request
    if !params[:id].nil?
      dn = Dnote.find_by_id(params[:id])

      if !dn.nil?
        dn.delete
      end
    end

    render json:nil, status: :ok
  end

  def usage
    @dname = params[:device_name]
    @ulogs = Dnote.where(:device_name=>@dname).order(:updated_at=>:desc)
  end

  def password
    # set page rows
    if params[:password_rows].nil? || params[:password_rows].blank?
      @rows = 5
    else 
      @rows = params[:password_rows]
    end
    # show page number
    if params[:page].nil?
      @page_number = 1
    else
      @page_number = params[:page]
    end

    if params[:button2] == 'modify'
      du = DeviceUser.find_by_device_name(params[:device_name])

      if !du.nil? || !du.blank?
        du.update(:username=>params[:username], :password=>params[:password], :device_name=>params[:device_name])
      end
    end

    if params[:button2] == 'remove'
      du = DeviceUser.find_by_device_name(params[:device_name])
      if !du.blank?
        du.delete
      end

      # de = Device.where(:name=>params[:device_name])
      de = Device.find_by_name(params[:device_name])

      if !de.blank?
        de.delete
      end
    end
    
    @dname = params[:device_name]
    # @devices = Device.where(:owner=>current_user.username).order(:updated_at=>:desc).paginate(:page=>params[:page], :per_page=>@rows)
    @devices = Device.where(:name => @dname).order(:updated_at=>:desc).paginate(:page=>params[:page], :per_page=>@rows)
    @count = DeviceUser.all.count
    
  end

  def modify_duser
    redirect_to password_devices_path
    # redirect_to devices_url
  end
  # GET /devices/1
  # GET /devices/1.json
  def show
    # saction
    if !params[:device_id].nil?
      Device.saction(params)
    end

    tmp = Dnote.where(:is_checked=>"0")
    @dnote_count = tmp.count

    if @dnote_count > 0
      @dnote_content = tmp.last.request_order
    end
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create

    @device = Device.new(device_params)
    @device.id = 100000 + rand(999999-100000)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end

    # UserMailer.cdevice_email(@device, current_user).deliver
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:name, :device_type, :location, :public_ip, :private_ip)
    end
end
