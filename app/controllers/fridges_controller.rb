class FridgesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @fridge = @user.fridge
  end
end
