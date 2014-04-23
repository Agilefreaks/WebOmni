require_relative '../../../lib/orm_adapter/adapters/active_resource'

module Concerns::UserDevise
  extend ActiveSupport::Concern

  included do
    extend Devise::Models

    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable, :validatable
    # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:google_oauth2]

    # Database authenticatable
    attr_accesible :email, :encrypted_password

    # Recoverable
    attr_accesible :reset_password_token, :reset_password_sent_at

    # Rememberable
    attr_accesible :remember_created_at

    # Trackable
    attr_accesible :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
  end

  module ClassMethods
    def to_adapter
      ActiveResource::OrmAdapter.new(self)
    end
  end

  def as_json(options = nil)
    self.attributes
  end
end
