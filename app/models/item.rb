# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  price       :string(255)
#  location    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Item < ActiveRecord::Base
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :description
  
  
  belongs_to :user
  belongs_to :category
  
  has_many :comments, :dependent =>:destroy
  has_many :favorites
  has_many :users, :through => :favorites
  
  
  has_many :pictures, :dependent => :destroy
  
  
end
