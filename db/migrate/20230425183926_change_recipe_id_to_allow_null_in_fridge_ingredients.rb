class ChangeRecipeIdToAllowNullInFridgeIngredients < ActiveRecord::Migration[6.0]
  def change
    change_column_null :fridge_ingredients, :recipe_id, true
  end
end
