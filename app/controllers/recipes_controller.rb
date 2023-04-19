class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
    @recipe.steps.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
  
    if @recipe.save
      attach_step_images(@recipe, params[:recipe][:steps_attributes])
      flash[:notice] = "レシピが投稿されました。"
      redirect_to @recipe
    else
      render 'new'
    end
  end
  
  def update
    if @recipe.update(recipe_params)
      attach_step_images(@recipe, params[:recipe][:steps_attributes])
      flash[:notice] = "レシピが更新されました。"
      redirect_to @recipe
    else
      render 'edit'
    end
  end
  
  def edit
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_url, notice: "レシピが正常に削除されました。"
  end

  private
  
  def attach_step_images(recipe, steps_attributes)
    steps_attributes.each do |_, step_attributes|
      next unless step_attributes[:step_image]

      step = recipe.steps.find(step_attributes[:id])
      step.step_image.attach(step_attributes[:step_image])
    end
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :content, images: [], steps_attributes: [:id, :description, :step_image, :_destroy])
  end
end