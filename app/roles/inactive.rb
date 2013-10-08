module Inactive
  def activate(token, device)
    activation_token = self.activation_tokens.where(content: token).first
    activation_token.update_attributes!(
      used: true,
      type: ActivationToken::TYPES[device] || ActivationToken::TYPES['unknown']
    )
  end
end