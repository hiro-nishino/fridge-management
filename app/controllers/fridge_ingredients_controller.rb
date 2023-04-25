class FridgeIngredientsController < ApplicationController
  before_action :set_fridge, only: [:create, :destroy]

  def create
    @fridge = Fridge.find(params[:fridge_id])
  
    params[:name].zip(params[:quantity], params[:expiration_date]).each do |name, quantity, expiration_date|
      ingredient = Ingredient.find_or_create_by(name: name)
      @fridge.fridge_ingredients.create(name: name, quantity: quantity, expiration_date: expiration_date, recipe_id: nil)
    end
  
    redirect_to user_fridge_path(@fridge.user, @fridge), notice: '食材が冷蔵庫に追加されました。'
  end

  def destroy
    @fridge_ingredient = FridgeIngredient.find(params[:id])
    @fridge_ingredient.destroy
    redirect_to user_fridge_path(current_user, @fridge_ingredient.fridge), notice: '食材を削除しました。'
  end

  private

  def set_fridge
    @fridge = Fridge.find(params[:fridge_id])
  end

  def ingredients_params
    params.permit(name: [], expiration_date: [], quantity: []).to_h.map do |key, values|
      values.map.with_index { |value, index| [key, value] }.to_h
    end
  end
end