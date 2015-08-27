json.array!(@categories) do |category|
  json.extract! category, :id, :catname
  json.url category_url(category, format: :json)
end
