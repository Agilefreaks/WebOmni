require 'grape'
require 'grape-swagger'

module WebOmni
  class Root < Grape::API
    version 'v1', :using => :path, vendor: 'omnipaste', cascade: false
    format :json
    default_error_formatter :json

    rescue_from Mongoid::Errors::DocumentNotFound do
      rack_response({error: {message: "We didn't find what we were looking for"}}.to_json, 404)
    end

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

    helpers do
      def current_user
        @current_user ||= User.where(email: headers['Channel']).first
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end

    mount Resources::ClippingsAPI
    mount Resources::DevicesAPI
    mount Resources::ActivationAPI

    if Rails.env.development?
      add_swagger_documentation(
          base_path: "#{Rails.configuration.action_mailer.default_url_options[:host]}/api",
          api_version: 'v1',
          mount_path: 'doc',
          hide_documentation_path: true,
          markdown: true
      )
    end
  end
end