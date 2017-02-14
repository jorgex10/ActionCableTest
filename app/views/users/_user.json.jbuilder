json.user_id user.id
json.full_name user.full_name
json.email user.email
json.photo user.photo.file? ? user.photo : user.avatar_url