require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  include Statuses
  expected_statuses = ['public', 'private', 'archived']

  test "should not save article without title" do
   
    article = articles(:no_title)
    assert_not article.save, "Saved an article without a title"
  end

  test "should not save article without body or short amount of text" do
    article = articles(:no_body)
    assert_not article.save, "Saved an article without a body"

    # Tests whether the body has the right amount of text
    article.body = "nah"
    assert_not_operator article.body.length, :>=, 10, "Body article has a valid amount of text"
    assert_not article.save, "Saved an article whether the body less than the minimum amount of text"
  end

  test "should not save article without status or an invalid one" do
    article = articles(:no_status)
    assert_not article.save, "Saved an article without a status"

    # Testing with a status that is not valid
    # Status could only be one of the values available in the VALID_STATUSES array
    article.status = "invalid status"
    assert_not_includes VALID_STATUSES, article.status, "Article with invalid status passed model validation"
    assert_not article.save, "Saved an article with an invalid status"
  end

  test "validates article with permited statuses only" do
    article = articles(:valid)

    VALID_STATUSES.each do |status|
      article.status = status
      assert_includes expected_statuses, article.status, "Invalid status present is Statuses concern was assigned to an article"
      assert article.valid?, "Could not validate article with valid status (#{status})"
    end
  end
end
