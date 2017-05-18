require 'test_helper'

class CommentTest < ActiveSupport::TestCase
	def setup
		@user = User.new(name: "test", email: "test@test.com")
		@user.save
		@post = Post.new(body: "text here", author: @user)
		@post.save
		@comment = Comment.new(body: "comment here", user: @user, post: @post)
	end

	test "should be valid" do
		assert @comment.valid?
	end

	test "should keep reference to the commenter" do
		@comment.save
		assert @comment.user = @user
	end

	test "should keep reference to the parent post" do
		@comment.save
		assert @comment.post = @post
	end
end
