module PhoneCalls
  class FindApiClientAssociation < UseCase::Base
    def before
      @api_client_id = context.api_client_id
    end

    def perform
      context.client_association = OmniApi::User::ClientAssociation.find(@api_client_id)
    rescue ActiveResource::ResourceNotFound
      failure(:client_association, 'The api client association could not be found')
    end
  end
end
