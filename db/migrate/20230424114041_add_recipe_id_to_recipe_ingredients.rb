class AddRecipeIdToRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :recipe_ingredients, :recipe_id, :bigint
    add_index :recipe_ingredients, :recipe_id
  end
end
