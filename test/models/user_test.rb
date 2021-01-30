require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should save new user" do
    user = User.new(email: "henriqueta@railsblog.com", password: 'secret' )
    assert user.save
  end

  test "should not save user without an email" do
    user = User.new(password: 'secret')
    assert_not user.save
  end

  test "should not save user without a password" do
    user = User.new(email: "henriqueta@railsblog.com" )
    assert_not user.save
  end

  test "should not allow creation with an email already in use" do
    user = User.new(email: users(:valid).email, password: 'secret' )
    assert_not user.save
  end
end
