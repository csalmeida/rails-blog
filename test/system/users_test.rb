require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:valid)
  end

  # This route is not available in the app
  # test "visiting the index" do
  #   visit users_url
  #   assert_selector "h1", text: "Users"
  # end

  test "user can sign in" do
    visit signin_url

    fill_in "Email", with: @user.email
    fill_in "Password", with: 'secret'
    click_button "Sign In"
  end

  test "user can sign out" do
    visit signin_url

    fill_in "Email", with: @user.email
    fill_in "Password", with: 'secret'
    click_button "Sign In"

    click_on "Sign Out"
  end

  test "creating a User" do
    visit signup_url

    fill_in "Email", with: 'newuser@railsblog.com'
    fill_in "Password", with: 'secret'
    fill_in "Password confirmation", with: 'secret'
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit signin_url

    fill_in "Email", with: @user.email
    fill_in "Password", with: 'secret'
    click_button "Sign In"

    visit user_url(@user)
    click_on "Edit", match: :first

    fill_in "Email", with: @user.email
    fill_in "Password", with: 'secret'
    fill_in "Password confirmation", with: 'secret'
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit signin_url

    fill_in "Email", with: @user.email
    fill_in "Password", with: 'secret'
    click_button "Sign In"

    visit user_url(@user)

    accept_confirm do
      click_on "Delete account", match: :first
    end

    assert_text "User was successfully destroyed"
  end
end
