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
          fill_in "Content", with: "Lorem ipsum"
      	end

      	it "should increase post count" do
      	  expect { click_button "Create Post" }.to change(Post, :count).by(1)
      	end

      	it "should redirect to #show" do
      	  click_button "Create Post"
      	  current_path.should == "/posts/2"

      	  subject.should have_content("Title")
          subject.should have_content("Lorem ipsum") 
          subject.should have_content("Disqus") 
      	end
      end
    end

    describe "manipulating an existing post" do
      before { visit "/posts/1" }

      describe "edit" do
        before do 
          click_link "Edit Post"
        end

        it { should have_selector('h1', 'Edit Post') }

        describe "editing a post" do
          let(:new_title) { "New Title" }
          let(:new_content) { "New Content" } 

          before do
            fill_in "Title", with: new_title
            fill_in "Content", with: new_content
            click_button "Update Post"
          end

          it "should redirect to post#show" do
            current_path.should == "/posts/1"
          end

          it { should have_selector('h2', text: new_title) }
          it { should have_content(new_content) }
        end

      end

      describe "delete" do
        it "should successfully delete a post" do
          expect { click_link "Delete Post"}.to change(Post, :count).by(-1)
        end
      end
    end
  end	
end