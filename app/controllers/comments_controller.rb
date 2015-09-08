class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html


  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def create
     @comment = current_user.comments.build(comment_params)
           respond_to do |format|
          if @comment.save
            format.html {redirect_to :back, :notice => "Congratulations, comment created Successfully."} 
            format.json { render json: {comment: @comment}, status: :created, location: @comment }
          else
            format.html { redirect_to :back, :notice => "Alas, comment could not be created."}
            format.json { render json: @comment.errors, status: :unprocessable_entity }
          end
        end
      
  end

  def destroy
    @comment.destroy
    respond_with(@comment)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:commentbody, :user_id, :item_id)
    end
end
