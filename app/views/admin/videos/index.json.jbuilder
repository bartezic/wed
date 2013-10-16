json.array!(@videos) do |video|
  json.extract! video, :link, :rating, :partner_id
  json.url admin_video_url(video, format: :json)
end
