json.array! @companies do |company|
  json.id company.id
  json.summary company.summary
end
