class CommentsController < ApplicationController
  include Statuses
  before_action :authenticated
  before_action :authorized, except: [:create]
  
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user_id = current_user.id
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

    if @comment.user === current_user
      if @comment.destroy
        redirect_to @article
      else
        render @article
      end
    else
      flash[:notice] = "You're not allowed to delete this comment."
      redirect_to @article
    end




  end

  private
   def comment_params
    params.require(:comment).permit(:body)
   end
end
