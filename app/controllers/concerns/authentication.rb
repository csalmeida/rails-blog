module Authentication
  extend ActiveSupport::Concern

  # This block is called within the scope of the class currently running at.
  included do
    helper_method :logged_in?, :current_user
  end

  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def logged_in?
    !!current_user
  end

  def authenticated
    redirect_to signin_path unless logged_in?
  end

  # Resource is an Active Record object that is either a user or can point to a user.
  def allowed?(resource)
    resource == current_user
  end
end