json.array!(@managers) do |admin_user|
  json.extract! admin_user, :name, :email, :avatar, :avatar_remote_url
  json.url admin_manager_url(admin_user, format: :json)
end
