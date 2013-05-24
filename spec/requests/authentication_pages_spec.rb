require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  describe "login page" do
    before { visit sign_in_path }

    it { should have_selector('h2', 'Administrator Sign in') }
  end

  describe "admin login" do
  	before { visit sign_in_path }

  	describe "with invalid information" do
      before { click_button "Sign in" }
      it { should have_content("Invalid email or password.") }
  	end

  	describe "after visiting another page" do
  	  before { click_link "Samantha Geitz" }
  	  it { should_not have_content("Invalid email or password.") }
  	end

  	describe "with valid information" do
  	  let(:admin) { FactoryGirl.create(:admin) }
  	  before do
  	  	fill_in "Email", with: admin.email
  	  	fill_in "Password", with: admin.password
  	  	click_button "Sign in"
  	  end

  	  it "redirects to index page on successful login" do
  	  	current_path.should == root_path
  	  end

  	  it { should have_content("Signed in successfully.") }
  	
  	  it { should have_content("Logout") }

  	  describe "admin logout" do
  	  	before do
  	  	  click_link "Logout"
  	  	end

  	  	it "redirects to index page on successful logout" do
  	  	current_path.should == root_path
  	    end

  	    it { should have_content("Signed out successfully.") }
  	
  	    it { should_not have_content("Logout") }
  	  end
  	end
  end

end