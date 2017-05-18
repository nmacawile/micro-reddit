require 'test_helper'

class PostTest < ActiveSupport::TestCase
	def setup
		@user = User.new(name: "test", email: "test@test.com")
		@user.save
		@post = Post.new(body: "text here", author: @user)		
	end

	test "should be valid" do
		assert @post.valid?
	end

	test "should keep reference to the author" do
		@post.save
		assert @post.author == @user
	end

	test "should keep references to all comments made under it" do
		@post.save
		comment1 = Comment.new(body: "comment1", post: @post, user: @user)
		comment1.save
		comment2 = Comment.new(body: "comment2", post: @post, user: @user)
		comment2.save
		assert @post.comments == [comment1, comment2]
	end

end
