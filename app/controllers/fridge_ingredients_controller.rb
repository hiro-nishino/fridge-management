class FridgeIngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fridge

  def index
    @fridge_ingredients = @fridge.fridge_ingredients
  end

  def create
    ingredient_names = params[:ingredient_name]
    quantities = params[:quantity]
  
    ingredient_names.each_with_index do |ingredient_name, index|
      ingredient = Ingredient.find_or_create_by(name: ingredient_name)
      fridge_ingredient = FridgeIngredient.new(
        ingredient: ingredient,
        fridge: @fridge,
        quantity: quantities[index]
      )
      fridge_ingredient.save
    end
  
    redirect_to fridge_path(@fridge)
  end

  def edit
    @fridge_ingredient = @fridge.fridge_ingredients.find(params[:id])
  end

  def update
    @fridge_ingredient = @fridge.fridge_ingredients.find(params[:id])
    if @fridge_ingredient.update(fridge_ingredient_params)
      redirect_to fridge_ingredients_path, notice: '食材が更新されました'
    else
      render :edit
    end
  end

  def destroy
    @fridge_ingredient = @fridge.fridge_ingredients.find(params[:id])
    @fridge_ingredient.destroy
    redirect_to fridge_ingredients_path, notice: '食材が削除されました'
  end

  private

  def set_fridge
    @fridge = current_user.fridge
  end

  def fridge_ingredient_params
    params.require(:fridge_ingredient).permit(:ingredient_id, :quantity)
  end
end