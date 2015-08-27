json.array!(@items) do |item|
  json.extract! item, :id, :title, :description, :price, :location
  json.url item_url(item, format: :json)
end
