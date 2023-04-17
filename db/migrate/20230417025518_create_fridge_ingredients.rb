class CreateFridgeIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :fridge_ingredients do |t|
      t.references :recipe,   null: false, foreign_key: true
      t.references :ingredient,   null: false, foreign_key: true
      t.integer     :quantity,      null: false
      t.timestamps
    end
  end
end
