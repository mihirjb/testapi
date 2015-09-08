# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string(255)
#

require 'valid_email'

class User < ActiveRecord::Base


include ActiveModel::Validations

acts_as_token_authenticatable


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         has_many :items, :dependent =>:destroy
         has_many :comments, :dependent =>:destroy
         has_many :favorites, :dependent =>:destroy
         has_many :relationships, :dependent =>:destroy
      
        has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :mini => "30x30>" }, :default_url => "/images/users/avatars/:style/missing.png"
        validates_attachment_content_type :avatar, :content_type => %w(image/jpeg image/jpg image/png)
      
         
         
           validates :email, :email => {:mx => true, :message => I18n.t('validations.errors.models.user.invalid_email')}
           validates :email, :email => {:ban_disposable_email => true, :message => I18n.t('validations.errors.models.user.invalid_email')}
 
 
 
           def as_json(options={})
             {
               id: self.id,
               email: self.email
             }
           end
         
end
