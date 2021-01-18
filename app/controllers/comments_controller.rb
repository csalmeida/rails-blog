class CommentsController < ApplicationController
  http_basic_authenticate_with name: "test", password: "test",
  only: :destroy

  include Statuses
  
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.status = 'public'
    @comment.save

    # Used to show errors in the articles view when a comment is submitted.
    if @comment.errors
      session[:comment_errors] = @comment.errors
    else
      session[:comment_errors] = nil
    end
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
  end

  private
   def comment_params
    params.require(:comment).permit(:commenter, :body)
   end
end
