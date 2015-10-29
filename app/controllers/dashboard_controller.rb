# class AdminController < ApplicationController
class DashboardController < ApplicationController

  before_action :authenticate_user!

  def index
    # tmp1 = Device.first
    # tmp2 = Device.last

    # if tmp1 != tmp2
    #   @devices = [tmp1, tmp2]
    # else 
    #   @devices = [ tmp1 ]
    # end

    # tmp1 = Ticket.first
    # tmp2 = Ticket.last

    # if tmp1 != tmp2
    #   @tickets = [tmp1, tmp2]
    # else 
    #   @tickets = [ tmp1 ]
    # end
    bs = false

    tmp = User.find_by_email(current_user.email)
    if !tmp.nil?
      if tmp.is_rticket || tmp.is_sticket || tmp.is_dticket || tmp.is_wticket
        bs = true
      else
        bs = false
      end
    else
      bs = false
    end    

    if bs
      @tickets = Ticket.order(:updated_at=>:desc)
    else
      @tickets = Ticket.where(:owner=>current_user.username).order(:updated_at=>:desc)
    end
    fresh_when @tickets
    @tickets = @tickets.paginate(:page => params[:page], :per_page => 2)

    bs = false

    @devices = Device.where(:owner=>current_user.username).order(:updated_at=>:desc)
    @devices = @devices.paginate(:page => params[:page], :per_page => 2)
    fresh_when @devices

    @open_tickets = Ticket.where(:owner=>current_user.username).count

    @note_count = Ticket.where(:owner=>current_user.username, :is_read=>"1").count
    
    @dnote_count = Dnote.where(:is_checked=>"0").count

  end
end
