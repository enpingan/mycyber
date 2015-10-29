require 'will_paginate/array'

class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /tickets
  # GET /tickets.json
  def index
    # confirm permission
    tmp = User.find_by_email(current_user.email)
    if !tmp.nil?
      if tmp.is_rticket || tmp.is_sticket || tmp.is_dticket || tmp.is_wticket
        bis = true
      else
        bis = false
      end
    else
      bis = false
    end
    
    # quick add
    if !params[:quickadd].blank?
      Ticket.quickadd(params[:quickadd])
    end
    
    # filter
    if !params[:group].nil?
      @filter_params = params
    end
    
    # sort
    @thd = []

    if !params[:sort_item].nil?
      did = Ticket.to_thdindex(params[:sort_item])

      if params[:direction] != ""
        if params[:direction] == "desc"
          @thd[did] = "_d"
        else
          @thd[did] = "_a"
        end
      end
    end

    if !params[:sort_item].nil?
      str_order = Ticket.ticket_sortable(params[:sort_item], params[:direction])
    end
    
    if str_order.nil?
      @tickets = Ticket.search(@filter_params).order(:is_read=>:desc).order(:updated_at=>:desc)
    else
      @tickets = Ticket.search(@filter_params).order(str_order).order(:is_read=>:desc).order(:updated_at=>:desc)
    end
    fresh_when @tickets

    # leave comment
    @comments = Comment.order(:updated_at=>:desc)
    # Paginate
    if params["ticket_rows"].nil?
      @rows = 5
    else 
      @rows = params["ticket_rows"]
    end

    # show page number
    if params[:page].nil?
      @page_number = 1
    else
      @page_number = params[:page]
    end

    # show info on notification bar
    if !@tickets.blank? || !@tickets.nil?
      @tickets = @tickets.paginate(:page => params[:page], :per_page => @rows.to_i)
    end

    tmp = Ticket.where(:owner=>current_user.username)
    # fresh_when tmp
    @open_tickets = tmp.count

    tmp = Ticket.where(:owner=>current_user.username, :is_read=>true)
    # fresh_when tmp
    # tmp = Ticket.where(:is_read=>true)

    # add comment
    if !params[:content].nil?
      Ticket.add_comments(params)
    end
    
    @note_count = tmp.count
    @ticket_count = @tickets.count
  end

  # def setrows
  #   redirect_to tickets_url, flash:{rows:params["ticket_rows"]}
  # end

  # def filter
  #   redirect_to tickets_url, flash:{filter_str:params}
  # end
  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  def quickadd
    @ticket = Ticket.new
    @ticket.id = 100000 + rand(999999-100000)

    @ticket.ticket_group = params["/tickets/quickadd"]["group"]
    @ticket.subject = params["/tickets/quickadd"]["subject"]
    @ticket.last_replied = params["/tickets/quickadd"]["owner"]
    @ticket.updated = params["/tickets/quickadd"]["updated"]
    @ticket.device = params["/tickets/quickadd"]["device"]
    @ticket.owner = params["/tickets/quickadd"]["last_replied"]
    # @ticket.user_id = params["/tickets/quickadd"]["user_id"]
    @ticket.is_read = params["/tickets/quickadd"]["is_read"]

    if @ticket.save
      UserMailer.created_email(@ticket, current_user).deliver
      # format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
      # format.json { render :show, status: :created, location: @ticket }
    end

    redirect_to tickets_url
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @user_name = current_user.id

    @emails = current_user.username
    # users = User.all
    # users.each do |u| 
    #   # @emails.push(u.email.split("@").first)
    # end

    # @devices = Device.all
    @devices = Device.where(:owner=>current_user.username)
  end

  def add_comments
    # add comment
    @tickets = Ticket.all

    if params[:commit] == "Reply"
      @comment = Comment.new
      # binding.pry
      # @comment.user_id = params[:user_id]
      # @comment.user_email = params[:user_email]
      # @comment.ticket_id = params[:ticket_id]
      # @comment.ticket_name = params[:ticket_name]
      # @comment.content = params[:content]
      @comment.comment = params[:content]
      @comment.ticket_id = params[:ticket_id]
      @comment.ticket_owner = params[:ticket_owner]

      current_ticket = @tickets.find_by_id(params[:ticket_id])
      current_ticket.is_read = params[:is_read]
      current_ticket.save

      if @comment.save
        UserMailer.comment_email(@comment).deliver
        # format.html { redirect_to @ticket, notice: 'Comment was successfully created.' }
        # format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

    redirect_to tickets_url
  end

  def check_comment 
    m_ticket = Ticket.find_by_id(params[:ticket_id]);
    m_ticket.is_read = false
    m_ticket.save
    render nothing: true
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.id = 100000 + rand(999999-100000)

    respond_to do |format|
      if @ticket.save
        UserMailer.created_email(@ticket, current_user).deliver
        format.html { redirect_to tickets_url, notice: 'Ticket was successfully created.' }
        # format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        # format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:ticket_group, :subject, :owner, :last_replied, :device, :updated, :user_id, :is_read, :detail)
    end

end
