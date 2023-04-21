class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.all
    @user = User.find(params[:user_id])
    @recipes = @user.recipes
  end

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

  def set_recipe
    @recipe = current_user.recipes.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :title, :content, images: [],
      steps_attributes: [:id, :direction, :step_images, :_destroy],
      recipe_ingredients_attributes: [:id, :name, :quantity, :is_seasoning, :_destroy]
    )
  end

  def self.search(search)
    if search != ""
      Tweet.where('text LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end

  def ensure_correct_user
    redirect_to recipes_path, alert: '権限がありません' unless current_user.id == @recipe.user_id
  end

  def cook
    recipe = Recipe.find(params[:id])
    fridge = current_user.fridge
  
    recipe.ingredients.each do |ingredient|
      fridge_ingredient = fridge.fridge_ingredients.find_by(ingredient_id: ingredient.id)
      if fridge_ingredient.present?
        new_quantity = fridge_ingredient.quantity - ingredient.recipe_ingredients.find_by(recipe_id: recipe.id).quantity
        if new_quantity > 0
          fridge_ingredient.update(quantity: new_quantity)
        else
          fridge_ingredient.destroy
        end
      else
        # 材料が冷蔵庫に存在しない場合の処理。必要に応じてエラーメッセージを表示するなど。
      end
    end
  
    # レシピが作成された後のリダイレクト先を指定します。
    redirect_to recipes_path, notice: 'レシピを作成しました。'
  end
end
