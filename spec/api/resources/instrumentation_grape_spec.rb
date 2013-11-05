require 'spec_helper'

describe NewRelic::Agent::Instrumentation::Grape do
  it 'traces' do
    NewRelic::Agent::Instrumentation::Grape
    .any_instance
    .should_receive(:perform_action_with_newrelic_trace)
    .and_yield

    get '/api/v1/clippings', nil, {Channel: 'email@domain.com'}

    expect(response.status).to eq 200
  end
end