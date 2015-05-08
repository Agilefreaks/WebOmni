class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Gravtastic
  include Analyzable
  include CalendarIdentity

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

  field :first_name
  field :last_name
  field :image_url

  field :plan, type: Symbol, default: :free

  validates :email, uniqueness: true

  def name
    "#{first_name} #{last_name}"
  end
end
