class FridgeIngredient < ApplicationRecord
  belongs_to :fridge
  belongs_to :recipe, optional: true
end
