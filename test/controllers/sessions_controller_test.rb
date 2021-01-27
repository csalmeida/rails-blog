require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get sign in action (#new)" do
    get signin_path
    assert_response :success
  end

  test "should get create and authenticate" do
    @user = users(:valid)
    post sessions_path, params: {
      email: @user.email,
      password: 'secret'
    }

    assert_redirected_to @user
  end

  test "should get create and fail authentication" do
    @user = users(:valid)
    post sessions_path, params: {
      email: @user.email
    }

    assert_redirected_to signin_path
  end
end
