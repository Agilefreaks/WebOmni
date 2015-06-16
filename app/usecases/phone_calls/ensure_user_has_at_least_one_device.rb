module PhoneCalls
  class EnsureUserHasAtLeastOneDevice < UseCase::Base
    def perform
      devices = OmniApi::User::Device.all
      failure(:devices, 'No devices found') if devices.empty?
    end
  end
end