class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :todos, dependent: :destroy

  before_create :generate_auth_token

  private

  def generate_auth_token
    self.auth_token = Devise.friendly_token
  end
end
