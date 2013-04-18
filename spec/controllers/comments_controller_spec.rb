require 'spec_helper'

describe CommentsController do

	before do 
		@comment = Comment.new(commenter: "John Doe", body: "Lorem ipsum")
	end

	subject { @comment }

	it { should respond_to(:commenter) }
	it { should respond_to(:body) }

	describe "when commenter is not present" do
		before { @comment.commenter = " " }
		it { should_not be_valid }
	end

	describe "when body is not present" do
		before { @comment.body = " " }
		it { should_not be_valid }
	end	

end
