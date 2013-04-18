# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  title      :string(255)
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base	
  attr_accessible :content, :name, :title

  validates :name, :presence => true
  validates :title, :presence => true,
  					:length => { :minimum => 5 }

  has_many :comments, :dependent => :destroy
end
