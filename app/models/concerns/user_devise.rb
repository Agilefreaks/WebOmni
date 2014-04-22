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

    schema do
      # Database authenticatable
      string :email
      string :encrypted_password

      # Recoverable
      string :reset_password_token
      string :reset_password_sent_at

      # Rememberable
      string :remember_created_at

      # Trackable
      integer :sign_in_count
      string :current_sign_in_at
      string :last_sign_in_at
      string :current_sign_in_ip
      string :last_sign_in_ip
    end
  end

  module ClassMethods
    def to_adapter
      ActiveResource::OrmAdapter.new(self)
    end
  end
end