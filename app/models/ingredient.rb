class Ingredient < ApplicationRecord
  belongs_to :category
  has_many :fridge_ingredients
  has_many :fridges, through: :fridge_ingredients
end
