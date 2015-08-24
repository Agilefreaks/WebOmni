module OmniApi
  class Client < BaseClientModel
    attr_accessible :id, :name, :scopes

    def locale
      'en'
    end
  end
end
