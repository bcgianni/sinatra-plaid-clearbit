json.array! @transactions do |transaction|
  json.id transaction.id
  json.transaction_id transaction.id
  json.company_id transaction.name
  json.recurring transaction.recurring
end
