class Provider < ApiModel
  include Concerns::Timestamps

  attr_accesible :name, :uid, :auth, :email

  # relations
  belongs_to :user
end