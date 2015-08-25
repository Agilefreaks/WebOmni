describe OmniApi::Client do
  let(:instance ) { OmniApi::Client.new }

  describe :locale do
    subject { instance.locale }

    it { is_expected.to eq('ro') }
  end
end