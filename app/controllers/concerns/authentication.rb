module Authentication
  extend ActiveSupport::Concern

  # This block is called within the scope of the class currently running at.
  included do
    helper_method :logged_in?, :current_user
  end

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  def logged_in?
    !!current_user
  end

  def authenticated
    redirect_to signin_path unless logged_in?
  end

  def authorized
    if logged_in?
      message = "You are not allowed to perform this action 😳"
      # If user is trying to access someone else's user actions.
      if @user.class == User
        unless current_user.id === @user.id
          redirect_to root_path, notice: message
        end
      else
        redirect_to root_path, notice: message unless current_user.id === params[:user_id]
      end
    end
  end
end