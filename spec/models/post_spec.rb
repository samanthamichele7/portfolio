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
  
  let(:admin) { FactoryGirl.create(:admin) }
  before { @post = admin.posts.build(name: "Administrator", title: "Title", content: "Lorem ipsum") }

  subject { @post }

  it { should respond_to(:name) }
  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:admin_id) }
  it { should respond_to(:admin) }
  its(:admin) { should == admin }

  it { should be_valid }
 
  describe "accessible attributes" do
    it "should not allow access to the admin's admin_id" do
      expect do
        Post.new(admin_id: admin.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
 
  describe "when user id is not present" do
    before { @post.admin_id = nil }
  	it { should_not be_valid }
  end

  describe "without a name" do
  	before { @post.name = " " }
  	it { should_not be_valid }
  end

  describe "with a blank title" do
    before { @post.title = " " }
    it { should_not be_valid }
  end

  describe "with blank content" do
  	before { @post.content = " " }
  	it { should_not be_valid }
  end

end
