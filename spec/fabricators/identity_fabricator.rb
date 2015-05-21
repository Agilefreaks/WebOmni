Fabricator(:identity) do
end

Fabricator(:expired_identity, from: :identity) do
  expires true
  expires_at DateTime.now - 1.days
end

Fabricator(:valid_identity, from: :identity) do
  expires true
  expires_at DateTime.now + 1.days
  token 'token'
  refresh_token 'refresh_token'
  scope 'calendar.readonly'
end