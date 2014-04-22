class Provider < ActiveResource::Base
  include Timestamps

  # fields
  schema do
    string :name
    string :uid
    string :auth
    string :email
  end

  # relations
  belongs_to :user
end