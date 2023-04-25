class Fridge < ApplicationRecord
  belongs_to :user
  has_many :fridge_ingredients
end
