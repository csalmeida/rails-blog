require "test_helper"

# Sign in tests are done manually
# Sign in helpers are also tested here

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "user can sign in via test helper" do
    @user = users(:valid)
    sign_in_as(@user, "secret")
    assert_equal session[:user_id].to_i, @user.id
  end

  test "user can sign out via test helper" do
    sign_out()
    assert_nil session[:user_id]
  end

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

    assert_redirected_to signin_url
  end

  test "should destroy session" do
    delete sessions_path
    assert_redirected_to root_path
  end
end
