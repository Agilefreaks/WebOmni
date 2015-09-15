module OmniApi
  class OmniApiConnection < ActiveResource::Connection

    attr_accessor :error_handler

    private

    def request(method, path, *arguments)
      super
    rescue Error => e
      error_handler.present? ? error_handler.handle(e) : raise
    end
  end
end