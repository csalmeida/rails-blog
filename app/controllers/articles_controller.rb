class ArticlesController < ApplicationController
  # Authentication is not present when running tests.
  http_basic_authenticate_with name: "test", password: "test",
  except: [:index, :show] unless Rails.env.test?
  
  include Statuses

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    valid_statuses()
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    valid_statuses()
  end

  def update
    @article = Article.find(params[:id])
    valid_statuses()

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
