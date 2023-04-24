class RemoveCategoryFromIngredients < ActiveRecord::Migration[6.0]
  def change
    remove_reference :ingredients, :category, foreign_key: true
  end
end
