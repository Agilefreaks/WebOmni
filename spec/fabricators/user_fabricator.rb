Fabricator(:user) do
  access_token 'someToken'
  email 'some_user@email.com'
  password 'the art of war'
  password_confirmation 'the art of war'
end

Fabricator(:user_without_calendar_access, from: :user) do
  email 'email@domain.com'
  plan PaymentPlan::FREE
end

Fabricator(:user_with_calendar_access, from: :user) do
  email 'email@domain.com'
  plan PaymentPlan::PREMIUM
end
