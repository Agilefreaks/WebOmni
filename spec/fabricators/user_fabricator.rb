Fabricator(:user) do
  email 'some@email.com'
  password '12345678'
  activation_tokens { [] }
end