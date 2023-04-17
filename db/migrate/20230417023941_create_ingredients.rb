class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.string   :name,      null: false 
      t.integer     :quantity,      null: false
      t.references :category,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
