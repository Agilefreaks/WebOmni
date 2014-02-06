require 'spec_helper'

describe NewRelic::Agent::Instrumentation::Grape do
  context 'user logged in' do
    include_context :logged_in_as_user

    it 'traces' do
      NewRelic::Agent::Instrumentation::Grape
      .any_instance
      .should_receive(:perform_action_with_newrelic_trace)
      .and_yield

      get '/api/v1/clippings/last', nil, {Channel: current_user.email}

      expect(response.status).to eq 200
    end
  end
end