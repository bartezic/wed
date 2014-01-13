json.array!(@slider_ads) do |slider_ad|
  json.extract! slider_ad, :asset, :active, :active_to
  json.url admin_slider_ad_url(slider_ad, format: :json)
end
