class User < ApplicationRecord
  rolify
  # enum role: [:user, :admin]
  # after_create :set_default_role
  # has_many :users_roles
  # has_many :roles, through: :users_roles


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :omniauthable , omniauth_providers: %i[facebook]

  validates :password, password: true, unless: -> { password.blank? }
  validates :phone, phone_number: true

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
