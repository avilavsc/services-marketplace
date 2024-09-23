class Contract < ApplicationRecord
  belongs_to :service
  belongs_to :user

  validates :status, presence: true, inclusion: { in: %w[ pending completed canceled ] }
end
