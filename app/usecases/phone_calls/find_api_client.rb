module PhoneCalls
  class FindApiClient < UseCase::Base
    def before
      @api_client_id = context.api_client_id
    end

    def perform
      begin
        context.api_client = OmniApi::User::Client.find(@api_client_id)
      rescue ActiveResource::ResourceNotFound
        failure(:api_client, 'The api client could not be found')
      end
    end
  end
end