Fabricator(:user) do
  access_token 'someToken'
  email 'some_user@email.com'
  password 'the art of war'
  password_confirmation 'the art of war'
end
