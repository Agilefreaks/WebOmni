module PhoneCalls
  class EnsureReadyForPhoneCallUseCase < UseCase::Base
    depends FindApiClient, EnsureUserHasAtLeastOneDevice
  end
end