json.array!(@partners) do |partner|
  json.extract! partner, :name, :description, :info, :price, :location_id, :site, :email, :phone, :active, :premium, :premium_to, :cover, :rating, :encrypted_password, :slug
  json.url cabinet_partner_url(partner, format: :json)
end
