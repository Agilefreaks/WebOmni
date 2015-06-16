module PhoneCalls
  class EnsureReadyForPhoneCallUseCase < UseCase::Base
    depends FindApiClient
  end
end