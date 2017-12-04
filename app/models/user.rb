class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :confirmable unless ENV['DEPLOY_BUTTON']

  validates :auth_token, presence: :true

  has_many :todos, dependent: :destroy
  has_many :lists, dependent: :destroy

  before_validation :generate_auth_token, on: :create

  private

  def generate_auth_token
    self.auth_token = Devise.friendly_token
  end
end
