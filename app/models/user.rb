class User < ApplicationRecord
  rolify

  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable , omniauth_providers: %i[facebook]
      
  validates :password, password: true
  validates :phone, phone_number: true, presence: true
  validates :name, presence: true, length: { minimum:6, maximum: 30 }

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
    end
  end
end
