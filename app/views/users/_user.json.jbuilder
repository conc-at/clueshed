json.(user, :id, :username)
json.url user_url(username: user.username, format: :json)
