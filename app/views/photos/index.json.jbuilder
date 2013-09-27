json.array!(@photos) do |photo|
  json.extract! photo, :asset, :rating, :gallery_id
  json.url photo_url(photo, format: :json)
end
