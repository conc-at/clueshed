json.array!(@contribs) do |contrib|
  json.extract! contrib, :id, :title, :description
  json.url contrib_url(contrib, format: :json)
end
