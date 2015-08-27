# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  catname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  has_many :items
end
