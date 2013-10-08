class ActivationContext
  attr_reader :user, :token, :device

  def self.call(user, token, book)
    ActivationContext.new(user, token, book).call
  end

  def initialize(user, token, device)
    @user, @token, @device = user, token, device

    @user.extend Inactive
  end

  def call
    @user.activate(@token, @device)
  end
end