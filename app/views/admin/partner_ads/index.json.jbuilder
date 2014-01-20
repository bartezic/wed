json.array!(@partner_ads) do |partner_ad|
  json.extract! partner_ad, :title, :description, :partner_id
  json.url admin_partner_ad_url(partner_ad, format: :json)
end
