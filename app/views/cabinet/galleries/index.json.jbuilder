json.array!(@galleries) do |gallery|
  json.extract! gallery, :name, :description, :partner_id
  json.url cabinet_gallery_url(gallery, format: :json)
end
