Fabricator(:user) do
  password 'the art of war'
  password_confirmation 'the art of war'
end

Fabricator(:user_without_calendar_access, from: :user) do
  email 'email@domain.com'
end

Fabricator(:user_with_calendar_access, from: :user) do
  email 'email@domain.com'
end
