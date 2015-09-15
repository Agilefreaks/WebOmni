describe CalendarPolicy do
  let(:user) { User.new }
  let(:calendar) { Calendar.new }
  let(:instance) { CalendarPolicy.new(user, calendar) }

  describe 'access?' do
    subject { instance.access? }

    context 'user has no plan' do
      before { user.plan = nil }

      it { is_expected.to be(false) }
    end

    context 'user has a free plan' do
      before { user.plan = OmniApi::Resources::PaymentPlan::FREE }

      it { is_expected.to be(false) }
    end

    context 'user has a premium plan' do
      before { user.plan = OmniApi::Resources::PaymentPlan::PREMIUM }

      it { is_expected.to be(true) }
    end
  end
end