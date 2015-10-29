json.array!(@devices) do |device|
  json.extract! device, :id, :name, :type, :location, :public_ip, :private_ip
  json.url device_url(device, format: :json)
end
