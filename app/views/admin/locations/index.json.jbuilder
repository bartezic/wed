json.array!(@locations) do |location|
  json.extract! location, :name, :slug
  json.url admin_location_url(location, format: :json)
end
