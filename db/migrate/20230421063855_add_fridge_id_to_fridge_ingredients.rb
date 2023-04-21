class AddFridgeIdToFridgeIngredients < ActiveRecord::Migration[6.0]
  def change
    add_reference :fridge_ingredients, :fridge, null: false, foreign_key: true
  end
end
