module OmniApi
  class BaseModel < ActiveResource::Base
    include Concerns::Attributes

    def as_json(options = nil)
      self.attributes
    end
  end
end