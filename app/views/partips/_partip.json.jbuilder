json.(partip, :id, :title, :created_at, :updated_at)
json.description markdown(partip.description)
json.user do
  json.partial! 'users/user', user: partip.user
end
json.votes partip.votes.length
json.url polymorphic_url partip
