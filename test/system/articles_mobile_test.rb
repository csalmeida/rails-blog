require "application_system_test_case"

# These tests run on a smaller screen size.
class ArticlesMobileTest < ApplicationSystemTestCase
  test "viewing the index" do
    visit articles_path
    assert_selector "h1", text: "Articles"
  end
end
