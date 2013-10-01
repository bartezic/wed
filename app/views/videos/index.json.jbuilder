json.array!(@videos) do |video|
  json.extract! video, :title, :description, :asset, :rating, :partner_id
  json.url video_url(video, format: :json)
end
