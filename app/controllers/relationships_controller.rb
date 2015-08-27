class RelationshipsController < ApplicationController
   respond_to :html

    def decide
      @instance = Relationship.where('follower_id = ? AND followed_id = ?' ,current_user.id, params[:user_id]).first
      if @instance  
        @instance.destroy
        render :nothing => true

      else
      Relationship.create(:follower_id => current_user.id,:followed_id => params[:user_id])
      render :nothing => true
    end
  end


     def show 
       @relationship = Relationship.find(params[:id])
     end


  private

    def relationship_params
      params.require(:relationship).permit(:follower_id, :followed_id)
    end
end
