module OmniApi
  class Identity < BaseClientModel
    self.prefix += 'users/:user_id/'

    attr_accessible :provider, :scope, :expires, :expires_at, :token, :refresh_token

    def user_id=(user_id)
      prefix_options[:user_id] = user_id
    end
  end
end