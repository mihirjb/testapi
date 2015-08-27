class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html


  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def create
    @comment = Comment.new(comment_params)
     if @comment.save
        redirect_to :back, :notice => "Congratulations, comment created Successfully."
      else
        redirect_to :back, :notice => "Alas, comment could not be created."
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
