require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:valid)
    @user_alta = users(:alta)

    # Password has to match the one passed to BCrypt in fixtures.
    sign_in_as(@user, "secret")
  end

  # User are currently not listed anywhere in the app
  test "should not access index" do
    sign_out()

    assert_raises(ActionController::RoutingError) do
      get users_url
    end
  end

  test "should not access new" do
    sign_out()
    # This route should not be active.
    assert_raises(ActionController::RoutingError) do
      get root_path + "user/new"
    end
  end

  # The new action is accessed via /signup
  test "should get new via signup" do
    sign_out()
    get signup_url
    assert_response :success
  end

  test "should create user" do
    sign_out()
    assert_difference('User.count') do
      post users_url, params: { user: { email: 'samara@railsblog.com', password: 'secret', password_confirmation: 'secret' } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should not create user email address is taken" do
    sign_out()
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: @user.email, password: 'secret', password_confirmation: 'secret' } }
    end
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  # test "should not show a user than the one logged in" do
  #   get user_url(@user_alta)
  #   assert_not_response :success
  # end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  # test "should not get edit of another user" do
  #   get edit_user_url(@user_alta)
  #   assert_not_response :success
  # end

  test "should update user" do
    patch user_url(@user), params: { user: { email: @user.email, password: 'secret', password_confirmation: 'secret' } }
    assert_redirected_to user_url(@user)
  end

  test "should not access destroy user" do

    assert_raises(ActionController::RoutingError) do
      delete user_url(@user)
    end

    # assert_difference('User.count', -1) do
    #   delete user_url(@user)
    # end

    # assert_redirected_to root_url
  end
end
