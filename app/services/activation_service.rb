class ActivationService
  def get_activation_token(user_id)
    user = User.find(user_id)

    user.activation_tokens.unused.first_or_create(user: user)
  end
end