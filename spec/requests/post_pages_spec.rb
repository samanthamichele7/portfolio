require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "PostPages" do
  
  subject { page }

  describe "without admin permissions" do
    
    before(:each) do 
      visit root_path
      post = FactoryGirl.create(:post)
    end

    it { should_not have_selector(:link_or_button, 'Logout') }

    describe "trying to create a new post" do
      before { visit new_post_path }

      it "should redirect to admin login page" do
      	current_path.should == '/admins/sign_in'
      end
    end

    describe "posts#show" do
      before { visit 'posts/1' }

      it { should_not have_selector(:link_or_button, 'Edit Post') }
      it { should_not have_selector(:link_or_button, 'Delete Post') }
    end
  end

  describe "as an admin" do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      post = FactoryGirl.create(:post)
      login_as(admin, :scope => :admin)
    end

    describe "index page" do
      before { visit posts_path }

      it { should have_selector(:link_or_button, 'New Post') }
    end

    describe "new post creation" do
      before { visit new_post_path }

      it { should have_selector('h1', 'New Post') }

      describe "add a new post" do
      	before do
      	  fill_in "Name", with: "Administrator"
      	  fill_in "Title", with: "Title"
      	end

      	it "should increase post count" do
      	  expect { click_button "Create Post" }.to change(Post, :count).by(1)
      	end

      	it "should redirect to #show" do
      	  click_button "Create Post"
      	  current_path.should == "/posts/2"

      	  subject.should have_content("Title")
      	end
      end
    end
  end	
end