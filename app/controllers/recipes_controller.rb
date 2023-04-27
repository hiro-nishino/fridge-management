class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.all
    if user_signed_in?
      @recipes = @recipes.includes([:user],).page(params[:page]).per(6)
    else
      @recipes = @recipes.includes([:user]).page(params[:page]).per(6)
    end
  end
  
  def show
  end

  def edit
  end
  
  def new
    @recipe = Recipe.new(flash[:recipe])
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    if @recipe.save
      redirect_to @recipe, notice: "レシピが投稿されました！"
    else
      render :new
    end
  end
  
  def search
    if params[:query].present?
      search = params[:query].downcase
      @search_recipes = Recipe.search_by_title_or_tag(search)
    else
      @search_recipes = Recipe.all
    end
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :content, :image, :tag_names, :serving_size, :user_id, ingredients_attributes: [:id, :name, :quantity, :_destroy], steps_attributes: [:id, :direction, :image, :_destroy])
  end

  def self.search(search)
    if search != ""
      @recipe.where('text LIKE(?)', "%#{search}%")
    else
      @recipe.all
    end
  end

  def made
    @recipe = Recipe.find(params[:id])
    fridge = current_user.fridge
  
    @recipe.recipe_ingredients.each do |recipe_ingredient|
      fridge_ingredient = fridge.fridge_ingredients.find_by(ingredient_id: recipe_ingredient.ingredient_id)
  
      if fridge_ingredient
        new_quantity = fridge_ingredient.quantity - recipe_ingredient.quantity
        fridge_ingredient.update(quantity: new_quantity)
        redirect_to recipes_path, notice: 'レシピを作りました！'
      end
    end
  
    redirect_to fridge_path(fridge), notice: '冷蔵庫の材料を更新しました。'
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