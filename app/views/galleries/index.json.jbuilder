json.array!(@galleries) do |gallery|
  json.extract! gallery, :name, :description, :partner_id
  json.url gallery_url(gallery, format: :json)
end
