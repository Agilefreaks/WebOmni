shared_context :logged_in_as_user do
  let(:current_user) { User.new(id: 42) }

  before do
    allow(controller).to receive(:authenticate!).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)
  end
end