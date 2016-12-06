json.array!(@registrations) do |registration|
  json.extract! registration, :id, :is_paid, :name, :subtype
  json.url registration_url(registration, format: :json)
end
