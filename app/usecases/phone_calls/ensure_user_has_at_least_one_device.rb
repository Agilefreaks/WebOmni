module PhoneCalls
  class EnsureUserHasAtLeastOneDevice < UseCase::Base
    def perform
      devices = OmniApi::Resources::User::Device.all
      failure(:devices, 'No devices found') if devices.count < 1
    end
  end
end
