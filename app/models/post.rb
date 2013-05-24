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
  attr_accessible :content, :title, :name

  belongs_to :admin

  validates :admin_id, :name, :content, :title, presence: true

  default_scope order: 'posts.created_at ASC'
end
