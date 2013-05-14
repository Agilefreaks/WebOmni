class API < Grape::API

  version 'v1', :using => :header, vendor: 'omnipaste', cascade: false
  format :json
  default_error_formatter :json

  rescue_from Mongoid::Errors::DocumentNotFound do |error|
    rack_response({'error' => {'message' => "We didn't find what we were looking for"}}.to_json, 404)
  end

  mount Users::APIV1
end
