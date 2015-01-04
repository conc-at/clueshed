json.extract! @interest, :id, :title, :created_at, :updated_at
json.description markdown(@interest.description)
