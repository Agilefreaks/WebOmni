module OmniApi
  module Concerns
    module Attributes
      extend ActiveSupport::Concern

      module ClassMethods
        def attr_accessible(*attr)
          attr.each do |a|
            define_method(a) { attributes[a] }
            define_method("#{a}=") { |val| attributes[a] = val }
          end
        end
      end
    end
  end
end
