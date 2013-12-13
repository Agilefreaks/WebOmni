class ActivateUser
  def self.with(token)
    ActivateUser.new(token).execute
  end

  attr_reader :token

  def initialize(token)
    @token = token
  end

  def execute
    user = User.find_by('activation_tokens.content' => @token, 'activation_tokens.used' => false)

    activation_token = user.activation_tokens.first_unused(@token)
    activation_token.update_attribute(:used, true)

    user
  end
end