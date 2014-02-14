require 'httparty'
require 'cgi'
require 'json'

class OmniNotificationService
  include HTTParty

  PUSH_URL = 'http://localhost:3001'
  base_uri PUSH_URL
  default_timeout 30
  format :json

  attr_accessor :timeout

  def send_notification(registration_ids, options = {})
    post_body = build_post_body(registration_ids, options)

    params = {
      :body => post_body.to_json,
      :headers => {
        #TODO: Add authorization 'Authorization' => "key=#{@api_key}",
        'Content-Type' => 'application/json',
      }
    }

    response = self.class.post('', params)
    build_response(response)
  end

  private

  def build_post_body(registration_ids, options={})
    { :registration_ids => registration_ids }.merge(options)
  end

  def build_response(response)
    case response.code
      when 200
        body = response.body || {}
        { :response => 'success', :body => body, :headers => response.headers, :status_code => response.code }
      when 400
        { :response => 'Only applies for JSON requests. Indicates that the request could not be parsed as JSON, or it contained invalid fields.', :status_code => response.code }
      when 401
        { :response => 'There was an error authenticating the sender account.', :status_code => response.code }
      when 500
        { :response => 'There was an internal error in the server while trying to process the request.', :status_code => response.code }
      when 503
        { :response => 'Server is temporarily unavailable.', :status_code => response.code }
    end
  end
end
