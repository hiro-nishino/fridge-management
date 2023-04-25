class RemoveIngredientFromFridgeIngredients < ActiveRecord::Migration[6.0]
  def change
    remove_reference :fridge_ingredients, :ingredient, null: false, foreign_key: true
  end
end
