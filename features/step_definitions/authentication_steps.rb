When(/^user with email "([^"]*)" does (not )?exist$/) do |email, does_not|
  user = { email: email, first_name: 'Calin', last_name: 'Balauru', access_token: 'calin access token' }
  users = [user]
  get_headers = { 'Accept' => 'application/json', 'Authorization' => OmniApi.config.client_access_token }
  post_headers = { 'Content-Type' => 'application/json', 'Authorization' => OmniApi.config.client_access_token }

  ActiveResource::HttpMock.respond_to do |mock|
    mock.get "/api/v1/users?email=#{Rack::Utils.escape(email)}", get_headers, does_not ? {}.to_json : users.to_json, 200
    mock.put '/api/v1/users/', post_headers, nil, 200
    mock.post '/api/v1/users', post_headers, nil, 201
  end
end

Then(/^I should see a "([^"]*)" and "([^"]*)"$/) do |download_label, authorization_label|
  expect(page).to have_content(download_label)
  expect(page).to have_content(authorization_label)
end
