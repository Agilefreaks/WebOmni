class ActivationContext
  attr_reader :user, :token, :device

  def self.activate(user, token, book)
    ActivationContext.new(user, token, book).activate
  end

  def self.get_activation_token(user)
    ActivationContext.new(user).get_activation_token
  end

  def initialize(user, token = '', device = '')
    @user, @token, @device = user, token, device

    @user.extend Inactive
  end

  def activate
    @user.activate(@token, @device)
  end

  def get_activation_token
    @user.get_activation_token
  end
end