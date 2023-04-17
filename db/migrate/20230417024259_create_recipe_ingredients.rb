class CreateRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_ingredients do |t|
      t.integer     :quantity,      null: false
      t.references :ingredient,   null: false, foreign_key: true
      t.references :category,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
