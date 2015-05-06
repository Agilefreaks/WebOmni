module OmniApi
  class PhoneCall < UserAuthorizedResource
    include Concerns::Timestamps

    attr_accessible :id, :number, :type, :state
  end
end
