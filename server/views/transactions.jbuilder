json.array! @transactions do |transaction|
  json.id transaction.id
  json.date transaction.date
  json.transaction_id transaction.id
  json.company_id transaction.name
  json.recurring transaction.recurring
  json.amount transaction.amount
  json.name transaction.name
end
