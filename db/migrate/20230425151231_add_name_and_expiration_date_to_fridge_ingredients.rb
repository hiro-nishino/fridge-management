class AddNameAndExpirationDateToFridgeIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :fridge_ingredients, :name, :string
    add_column :fridge_ingredients, :expiration_date, :date
  end
end
