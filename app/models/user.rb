class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :auth_token, presence: :true

  has_many :todos, dependent: :destroy

  before_validation :generate_auth_token, on: :create

  private

  def generate_auth_token
    self.auth_token ||= Devise.friendly_token
  end
end
