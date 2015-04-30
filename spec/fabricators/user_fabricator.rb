Fabricator(:user) do
  password 'the art of war'
  password_confirmation 'the art of war'
end

Fabricator(:user_with_calendar_access, from: :user) do
  email 'email@domain.com'
  expires true
  expires_at DateTime.now + 1.days
  token 'token'
  refresh_token 'refresh_token'
end
