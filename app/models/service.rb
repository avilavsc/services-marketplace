class Service < ApplicationRecord
  belongs_to :user
  has_many :contracts, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  def average_rating
    reviews.average(:rating).to_f
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[ title description ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
