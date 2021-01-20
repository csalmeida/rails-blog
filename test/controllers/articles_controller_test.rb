require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get articles_url
    assert_response :success

    assert_equal "index", @controller.action_name
    # assert_equal "application/x-www-form-urlencoded", @request.media_type
    assert_match "Articles", @response.body
  end

  test "should show article" do
    article = articles(:valid)
    get article_url(article)
    assert_response :success
  end

  test "should create article" do
    article = articles(:valid)

    assert_difference("Article.count") do
      post articles_url, params: {
        article: {
          title: article.title,
          body: article.body,
          status: article.status
        }
      }
    end

    assert_redirected_to article_path(Article.last)
    assert_equal "Article was successfully created.", flash[:notice]
  end
  
  test "should destroy article" do
    article = articles(:valid)

    assert_difference("Article.count", -1) do
      delete article_url(article)
    end

    assert_redirected_to articles_path
  end

  test "should update article" do
    article = articles(:valid)
    patch article_url(article), params: {
      article: {
        title: "Updated title"
      }
    }

    assert_redirected_to article_path(article)

    # Reload association to fetch updated data and assert that title is updated.
    article.reload
    assert_equal "Updated title", article.title
  end
end
