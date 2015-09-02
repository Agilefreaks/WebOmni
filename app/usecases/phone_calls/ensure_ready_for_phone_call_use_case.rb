module PhoneCalls
  class EnsureReadyForPhoneCallUseCase < UseCase::Base
    depends FindApiClientAssociation, EnsureUserHasAtLeastOneDevice
  end
end
