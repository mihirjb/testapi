class FavoritesController < ApplicationController

  respond_to :html

  def decide
    @instance = current_user.favorites.where('item_id = ?',params[:item_id]).first
    if @instance  
      @instance.destroy
      render :nothing => true
      
    else
    current_user.favorites.create(:item_id => params[:item_id])
    render :nothing => true
  end
end
  
   
   def show 
     @fav = Favorite.find(params[:id])
   end
   
  
  private
   
    def favorite_params
      params.require(:favorite).permit(:user_id, :item_id)
    end
end
