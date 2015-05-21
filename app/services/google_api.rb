module Google
  class Api
    def initialize
      @google_api_client = ::Google::APIClient.new(
        :application_name => 'Omnipaste',
        :application_version => '1.0.0')

      client_secrets = ::Google::APIClient::ClientSecrets.load('./config/client_secret.json')
      @google_api_client.authorization = client_secrets.to_authorization
      @google_api_client.authorization.scope = 'https://www.googleapis.com/auth/calendar'
    end

    def calendars
      Calendars.new(@google_api_client)
    end
  end
end