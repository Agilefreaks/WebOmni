class ActivationService
  def activate(token, device)
    user = User.find_by('activation_tokens.content' => token)
    activation_token = user.activation_tokens.unused.where(content: token).first

    if activation_token.nil?
      raise ActivationTokenNotFound.new
    end

    activation_token.update_attributes!(
      used: true,
      type: ActivationToken::TYPES[device] || ActivationToken::TYPES['unknown']
    )
  end

  def get_activation_token(user_id)
    user = User.find(user_id)
    user.activation_tokens.create! if user.activation_tokens.unused.count == 0

    user.activation_tokens.first
  end
end