module OmniApi
  module Concerns
    module Attributes
      extend ActiveSupport::Concern

      module ClassMethods
        def attr_accesible(*attribs)
          attribs.each do |a|
            define_method(a) { attributes[a] }
            define_method("#{a}=") { |val| attributes[a] = val }
          end
        end
      end
    end
  end
end