json.array!(@categories) do |category|
  json.extract! category, :name, :name_sing
  json.url category_url(category, format: :json)
end
