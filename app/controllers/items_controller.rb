class ItemsController < ApplicationController

  respond_to :html, :json
  
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items.json
  def index
    @items = Item.all
    respond_to do |format|
      format.json do
        render :json =>  {items: @items}
      end
    end
  end
  
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
    @user = current_user
    @comment = Comment.new
    @comments = Comment.where("item_id = ?",@item.id)
    respond_to do |format|
       format.html {
         respond_with(@item)
        }
      
      format.json {
        render json: @item
      }
    end
  end
  
  def new 
    @item = Item.new
    @categories = Category.all
  end
  
  # POST /items.json
  def create
    @item = current_user.items.build(item_params)

    respond_to do |format|
      if @item.save

        if params[:images]
          #===== The magic is here ;)
          params[:images].each { |image|
            @item.pictures.create(image: image)
          }
        end

        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @categories = Category.all
    
  end

  # PATCH /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @item, notice: "Alas! couldn't update the item"}
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
   private
      # Use callbacks to share common setup or constraints between actions.
      def set_item
        @item = Item.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def item_params
        if  ["index", "destroy", "show"].include?(params[:action]) 
          # Workaround when dealing with JSON:
          params.permit(:item) 
        else
          params.require(:item).permit(:title,:description, :price, :location, :category)
        end
      end
  end
