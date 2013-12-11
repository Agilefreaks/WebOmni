shared_context :logged_in_as_user do
  let(:current_user) { Fabricate(:user) }

  before(:each) { current_user }
end