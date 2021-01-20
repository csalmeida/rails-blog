require "test_helper"

class BlogFlowTest < ActionDispatch::IntegrationTest
  # An integration test, asserts something the user can do in the application.
  test "can see articles page" do
    get "/"
    assert_select "h1", "Articles"
  end

  test "can create an article" do
    get "/articles/new"
    assert_response :success

    post "/articles", params: {
      article: {
        title: "can create",
        body: "article successfully.",
        status: "private"
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h1", "can create"
  end
end
