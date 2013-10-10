class ActivationService
  def activate(token, device)
    user = User.find_by('activation_tokens.content' => token)
    activation_token = user.activation_tokens.first_unused(token)

    activation_token.update_attributes!(
      used: true,
      type: ActivationToken::TYPES[device] || ActivationToken::TYPES['unknown']
    )

    activation_token
  end

  def get_activation_token(user_id)
    user = User.find(user_id)

    user.activation_tokens.unused.first_or_create(user: user)
  end
end