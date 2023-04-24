class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true
 
  has_one_attached :image

  validates :title, presence: true
  validates :content, presence: true
  validates :serving_size, presence: true

end
