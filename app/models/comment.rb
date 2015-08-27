# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  commentbody :text
#  user_id     :integer
#  item_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :item, touch: true
  
   validates :commentbody, :presence => {:message => 'Heading cannot be blank, Listing not saved'}
   validates :commentbody, :length => {:maximum => 600}
   

  private
  def self.get_comment_count(item_id)
  @count = Comment.where("item_id = ?", item_id).count
  end

  def self.get_comment_author(comments_userid)
    @user =  User.find(comments_userid)
    @author = @newauthor  = @user.firstname
    @newauthor  = @user.firstname

    if @author
 		@author
 	else 
 		@newauthor
 	end

   end

   private

   def deny_to_visitors
     redirect_to root_path unless user_signed_in? or admin_signed_in?
   end
  
end
