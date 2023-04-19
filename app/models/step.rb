class Step < ApplicationRecord
  belongs_to :recipe
  validates :direction, presence: true
  
  belongs_to :recipe
  has_one_attached :step_images
end
