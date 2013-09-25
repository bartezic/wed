json.array!(@admin_users) do |admin_user|
  json.extract! admin_user, :name, :email, :avatar, :avatar_remote_url
  json.url admin_admin_user_url(admin_user, format: :json)
end
