
class Ticket < ActiveRecord::Base
  self.table_name = "Tickets"

  def self.quickadd(add_item)

    @ticket = Ticket.new
    @ticket.id = 100000 + rand(999999-100000)

    @ticket.ticket_group = add_item["group"]
    @ticket.subject = add_item["subject"]
    @ticket.last_replied = add_item["last_replied"]
    @ticket.updated = add_item["updated"]
    @ticket.device = add_item["device"]
    @ticket.owner = add_item["owner"]
    # @ticket.user_id = add_item["user_id"]
    @ticket.is_read = add_item["is_read"]

    if @ticket.save
      # UserMailer.created_email(@ticket, current_user).deliver
      # format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
      # format.json { render :show, status: :created, location: @ticket }
      return true
    else
      return false
    end
  end

  def self.add_comments(comment_params)
    if !comment_params.blank?
      if comment_params[:commit] == "Reply"
        comment = Comment.new
        
        comment.comment = comment_params[:content]
        comment.ticket_id = comment_params[:ticket_id]
        comment.ticket_owner = comment_params[:ticket_owner]
        comment.save

        current_ticket = Ticket.find_by_id(comment_params[:ticket_id])
        current_ticket.is_read = comment_params[:is_read]
        current_ticket.save
      end
    end
  end

  def self.search(filter_item)
    
    if !filter_item.blank? && !filter_item[:group].nil?
      tmp = filter_item
      
      tickets = Ticket.where("subject LIKE ? AND ticket_group LIKE ? AND owner LIKE ? AND device LIKE ? AND last_replied LIKE ? AND updated_at LIKE ?", "%#{tmp[:subject]}%", "%#{tmp[:group]}%", "%#{tmp[:onwer]}%", "%#{tmp[:device]}%", "%#{tmp[:last_replied]}%", "%#{tmp[:updated]}%")
    else
      tickets = Ticket.all
    end

    return tickets
  end

  def self.ticket_sortable(column, direction)
    case column
    when "Ticket #"
      col = "id "
    when "Group"
      col = "ticket_group "
    when "Subject"
      col = "subject "
    when "Owner"
      col = "owner "
    when "Last replied"
      col = "last_replied "
    when "Device"
      col = "device "
    when "Updated"
      col = "updated_at "
    else
      col = " "
    end

    return col + direction
  end

  def self.to_thdindex(sort_item)
    case sort_item
    when "Ticket #"
      col = 0
    when "Group"
      col = 1
    when "Subject"
      col = 2
    when "Owner"
      col = 3
    when "Last replied"
      col = 4
    when "Device"
      col = 5
    when "Updated"
      col = 6
    else
      col = 7
    end

    return col
  end

end

# if Ticket.connection.nil?
#   Ticket.establish_connection "user_panel_#{Rails.env}"
# end