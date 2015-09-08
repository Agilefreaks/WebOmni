class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Gravtastic
  include Analyzable

  is_gravtastic

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable,
         :registerable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         omniauth_providers: [:google_oauth2]

  has_one :identity, autobuild: true

  has_many :calendars

  ## Database authenticatable
  field :email,              type: String, default: ''
  field :encrypted_password, type: String, default: ''

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  field :access_token
  field :refresh_token
  field :access_token_expires_at, type: Time

  field :first_name
  field :last_name
  field :image_url

  field :plan, type: String, default: PaymentPlan::FREE

  validates :email, uniqueness: true

  def name
    "#{first_name} #{last_name}"
  end

  def access_token_expired?
    access_token_expires_at.blank? || access_token_expires_at < DateTime.current
  end
end
