json.extract! @interest, :id, :title, :created_at, :updated_at, :user
json.description markdown(@interest.description)
