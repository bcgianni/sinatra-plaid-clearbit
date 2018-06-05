json.array! @companies do |company|
  json.id company.id
  json.description company.description
  json.legal_name company.legal_name
  json.phone company.phone
  json.type company.type
end
