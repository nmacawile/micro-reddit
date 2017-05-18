require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
        @user = User.new(name: "test-user", email: "test-user@example.com")
	end

    test "should be valid" do
        assert @user.valid?
    end

    test "name should be present" do
        @user.name = "  "
        assert_not @user.valid?
    end

    test "email should be present" do
        @user.email = "  "
        assert_not @user.valid?
    end

    test "name should not be too long" do
        @user.name = "a" * 21
        assert_not @user.valid?
    end

    test "email should not be too long" do
        @user.email = "a" * 51 + "@example.com"
        assert_not @user.valid?
    end

    test "name validation should accept valid names" do
        valid_names = %w[user123
                         USeR_123
                         _underscores_
                         ___underscores__
                         -dashes-
                         A_US-ER
                         first_last]
        valid_names.each do |valid_name|
            @user.name = valid_name
            assert @user.valid?, "#{valid_name.inspect} should be valid"
        end
    end

    test "name validation should reject invalid names" do
        valid_names = %w[u$er122
                         u1
                         n@me3
                        'with space'
                         with.dot]
        valid_names.each do |valid_name|
            @user.name = valid_name
            assert_not @user.valid?, "#{valid_name.inspect} should be invalid"
        end
    end

    test "email validation should accept valid addresses" do
        valid_addresses = %w[user@example.com
                             USER@foo.COM
        	                 A_US-ER@foo.bar.org
        	                 first.last@foo.jp
        	                 alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
            @user.email = valid_address
            assert @user.valid?, "#{valid_address.inspect} should be valid"
        end
    end

    test "email validation should reject invalid addresses" do
        invalid_addresses = %w[user@example,com
    	                       user_at_foo.org
    	                       user.name@example.
                               foo@bar_baz.com
                               foo@bar+baz.com
                               foo@bar..com]
        invalid_addresses.each do |invalid_address|
            @user.email = invalid_address
            assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
        end
    end

    test "names should be unique" do
        duplicate_user = @user.dup
        duplicate_user.email = "duplicate@example.com"
        @user.save
        assert_not duplicate_user.valid?
    end

    test "email addresses should be unique" do
        new_user = User.new(name: "new_user", email: @user.email.upcase)
        @user.save
        assert_not new_user.valid?
    end

    test "email addresses should be saved as lower-case" do
        mixed_case_email = "TEst-UsER@ExAMPle.CoM"
        @user.email = mixed_case_email
        @user.save
        assert_equal mixed_case_email.downcase, @user.reload.email
    end
end
