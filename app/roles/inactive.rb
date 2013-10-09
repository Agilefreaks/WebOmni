module Inactive
  def activate(token, device)
    activation_token = self.activation_tokens.where(content: token).first

    if (activation_token.nil?)
      raise ActivationTokenNotFound.new
    end

    activation_token.update_attributes!(
      used: true,
      type: ActivationToken::TYPES[device] || ActivationToken::TYPES['unknown']
    )
  end

  def get_activation_token
    self.activation_tokens.create! if self.activation_tokens.count == 0

    self.activation_tokens.first
  end
end