class ItemsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index,:show]
  before_filter :prepare_categories

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    
    @items = Item.all
    @user = current_user
    @feeditems = Relationship.where('follower_id = ?',current_user.id).limit(100)
    respond_with(@items)
  end

  def show
    @item = Item.find(params[:id])
    @comment = @item.comments.build
    @comments = Comment.where('item_id = ?',@item.id).limit(50)
    @favcount = Favorite.where("item_id = ?", @item.id).count
    
  end

  def new
    @item = Item.new
    respond_with(@item)
  end

  def edit
  end

  def create
    @item = current_user.items.build(item_params)
   if  @item.save
    
    respond_to do |format|
      format.html {
        respond_with(@item)
        }
  
    format.json {
      render :json => { :item => @item }
    }
  end
  
end
    
  end

  def update
    @item.update(item_params)
    respond_with(@item)
  end

  def destroy
    @item.destroy
  redirect_to "/items"
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end
    def prepare_categories
          @categories = Category.all
        end

    def item_params
      params.require(:item).permit(:title, :description, :price, :location,:user_id, :category_id)
    end
end
