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

require 'spec_helper'

describe Post do
  
  before do
  	@post = Post.new(name: "Samantha Geitz", title: "Post Title", content: "Lorem ipsum dolor")
  end

  subject { @post }

  it { should respond_to(:name) }
  it { should respond_to(:title) }
  it { should respond_to(:content) }

  it { should be_valid }

  describe "when name is not present" do
  	before { @post.name = " " }
  	it { should_not be_valid }
  end

  describe "when title is not present" do
  	before { @post.title = " " }
  	it { should_not be_valid }
  end
 
end
