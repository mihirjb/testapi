class PagesController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:inbox]
  respond_to :html,:json
  
  def home
    @items = Item.all
  end

  def about
  end

  def faq
  end

  def terms
  end
  
  def profile
    @user = User.find(params[:id])
    @items = Item.where('user_id = ?',params[:id]).limit(50)
    @url ="http://localhost:3000/profiles?id=#{@user.id}"
  end 
  
  def favourites
     @user = User.find(params[:id])
      @items = Item.all
      @url ="http://localhost:3000/profiles?id=#{@user.id}"
      @favs = Favorite.where('user_id = ?',@user.id).limit(50)
  end
  
  
end
