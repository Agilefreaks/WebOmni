class Contact
  include Mongoid::Document

  field :email, type: String
  field :name, type: String
  field :message, type: String
end
