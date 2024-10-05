json.extract! user_profile, :id, :user_id, :name, :uin, :email, :contact_no, :role, :details, :auth_level, :created_at, :updated_at
json.url user_profile_url(user_profile, format: :json)
