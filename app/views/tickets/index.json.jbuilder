json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :group, :subject, :owner, :last_replied, :device, :updated
  json.url ticket_url(ticket, format: :json)
end
