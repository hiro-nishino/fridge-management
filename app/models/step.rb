class Step < ApplicationRecord
  belongs_to :recipe
  validates :direction, presence: true
  
  mount_uploader :image, StepImageUploader
  belongs_to :recipe
  has_many_attached :images
end
