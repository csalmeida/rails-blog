require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "should not save article without title" do
    article = Article.new(body: "A long piece of text", status: 'public')
    assert_not article.save, "Saved an article without a title"
  end

  test "should not save article without body or short amount of text" do
    article = Article.new(title: 'This article has no body', status: 'public')
    assert_not article.save, "Saved an article without a body"

    # Tests whether the body has the right amount of text
    article.body = "nah"
    assert_not_operator article.body.length, :>=, 10, "Body article has a valid amount of text"
    assert_not article.save, "Saved an article whether the body less than the minimum amount of text"
  end

  test "should not save article without status or an invalid one" do
    article = Article.new(title: 'This article has no body', body: "A long piece of text", status: nil)
    assert_not article.save, "Saved an article without a status"

    # Testing with a status that is not valid
    # Status could only be one of the values available in the VALID_STATUSES array
    article.status = "invalid status"
    assert_not article.valid?, "Article with invalid status passed model validation"
    assert_not article.save, "Saved an article with an invalid status"
  end
end
