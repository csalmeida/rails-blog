require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit articles_url
  #
  #   assert_selector "h1", text: "Articles"
  # end

  test "viewing the index" do
    visit articles_path
    assert_selector "h1", text: "Articles"
  end

  test "creating an article" do
    visit articles_path

    click_on "New Article"

    # Checks Status selection is rendered with the correct amount of options.
    assert_selector 'select[name~="article[status]"]', count: 1
    assert_selector "option", count: 3

    fill_in "Title", with: "Creating an Article"
    fill_in "Body", with: "Created this article successfully!"

    click_on "Create Article"

    assert_text "Creating an Article"
  end
end
