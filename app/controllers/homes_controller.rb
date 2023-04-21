class HomesController < ApplicationController
  def index
  end

  def search
    keyword = params[:keyword]
    if keyword.present?
      # 材料やタイトルから検索する処理をここに実装します。
    else
      @recipes = Recipe.none
    end
  end
end
