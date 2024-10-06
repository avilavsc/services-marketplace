class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :services, dependent: :destroy
  has_many :contracts, dependent: :destroy
  has_many :reviews, dependent: :destroy

  enum :role, { client: "client", provider: "provider" }
end
