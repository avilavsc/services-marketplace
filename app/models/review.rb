class Review < ApplicationRecord
  belongs_to :service
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :content, presence: true
  validates :service, uniqueness: { scope: :user, message: "Você já avaliou este serviço" }
end
