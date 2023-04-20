class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @recipe.steps.build
    @recipe.ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    if @recipe.save
      redirect_to @recipe, notice: 'レシピが投稿されました。'
    else
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :title, :content, images: [],
      steps_attributes: [:id, :direction, :step_images, :_destroy],
      recipe_ingredients_attributes: [:id, :name, :quantity, :is_seasoning, :_destroy]
    )
  end
end