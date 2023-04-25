class FridgesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @fridge = @user.fridge
  end

  def edit
    @fridge = Fridge.find(params[:id])
  end
  
  def update
    @fridge = Fridge.find(params[:id])
    if @fridge.update(fridge_params)
      redirect_to fridge_path(@fridge), notice: '冷蔵庫が更新されました。'
    else
      render :edit
    end
  end
  
  private
  def fridge_params
    params.require(:fridge).permit(:name, :description)
  end
end
