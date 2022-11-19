class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  rolify

  after_initialize :set_default_role

  has_many :comments, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :user_vouchers, dependent: :destroy
  has_many :vouchers, through: :user_vouchers, dependent: :destroy
  has_many :orders, dependent: :destroy

  has_one :cart, dependent: :destroy
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  validates :password, password: true, unless: -> { from_omniauth? }
  validates :phone, phone_number: true, presence: true, unless: -> { from_omniauth? }
  validates :name, presence: true, length: { minimum: 6, maximum: 30 }, unless: -> { from_omniauth? }
  validates :email, presence: true, uniqueness: true

  def display_image
    avatar.variant resize_to_limit: [300, 200]
  end

  def self.from_omniauth(auth)
    result = User.find_by(email: auth.info.email)
    return result if result

    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name.split('@').first
      # user.image = auth.info.image
      user.uid = auth.uid
      user.provider = auth.provider
      user.skip_confirmation!
    end
  end

  private

  def set_default_role
    self.roles ||= :user
  end

  def from_omniauth?
    provider && uid
  end
end
