json.array!(@videos) do |video|
  json.extract! video, :name, :description, :cover, :cover_remote_url, :link, :rating, :partner_id
  json.url cabinet_video_url(video, format: :json)
end
