# == Schema Information
#
# Table name: admins
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#


require 'spec_helper'

describe Admin do
  before do
  	@admin = Admin.new(email: "user@example.com", password: "foobar123", password_confirmation: "foobar123")
  end

  subject { @admin }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:posts) }

  describe "when email is not present" do
    before { @admin.email = " " }
    it { should_not be_valid }
  end

  # Devise validatable does not catch this one -- added VALID_EMAIL_REGEX to make sure format is OK
  describe "when email format is invalid" do
    it "should be invalid" do
	  addresses = %w[user@foo,com user_at_foo.org example.user@foo.
	              foo@bar_baz.com foo@bar+baz.com]
	  addresses.each do |invalid_address|
	    @admin.email = invalid_address
	    @admin.should_not be_valid
	  end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @admin.email = valid_address
        @admin.should be_valid
      end
    end
  end

  describe "when email address is already in use" do
    before do
      duplicate_admin = @admin.dup
      duplicate_admin.email = @admin.email.upcase
      duplicate_admin.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @admin.password = @admin.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password confirmation does not match" do
  	before { @admin.password_confirmation = "blah" }
  	it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
  	before { @admin.password_confirmation = nil }
  	it { should_not be_valid }
  end

  describe "with a password that is too short" do
  	before { @admin.password = "123" }
  	it { should_not be_valid }
  end

  describe "post associations" do
  	before { @admin.save }
  	let!(:older_post) do
  	  FactoryGirl.create(:post, admin: @admin, created_at: 1.day.ago)
  	end
  	let!(:newer_post) do
  	  FactoryGirl.create(:post, admin: @admin, created_at: 1.month.ago)
  	end

  	it "should display posts in correct order" do
  	  @admin.posts.should == [newer_post, older_post]
  	end

  	it "should destroy associated posts" do
  	  posts = @admin.posts.dup
  	  @admin.destroy
  	  posts.should_not be_empty
  	  posts.each do |post|
  	    Post.find_by_id(post.id).should be_nil
  	  end
  	end
  end  

end
