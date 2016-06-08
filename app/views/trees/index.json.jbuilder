json.array!(@trees) do |tree|
  json.extract! tree, :id, :title, :raw_text, :root_id
  json.url tree_url(tree, format: :json)
end
