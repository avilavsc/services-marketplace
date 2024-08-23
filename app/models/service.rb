class Service < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  def self.ransackable_attributes(auth_object = nil)
    %w[ title description ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
