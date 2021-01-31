module Authentication
  extend ActiveSupport::Concern

  # This block is called within the scope of the class currently running at.
  included do
    helper_method :logged_in?, :current_user
  end

  def current_user
    if session[:user_id]
      @current_user = User.find_by_id(session[:user_id])
    end
  end

  def logged_in?
    !!current_user
  end

  def sign_out
    session[:user_id] = nil
  end

  def authenticated
    redirect_to signin_path unless logged_in?
  end

  def authorized
    if logged_in?
      message = "You are not allowed to perform this action 😳"
      # Used to retrieve user id as param
      controller_symbol = params[:controller].singularize.parameterize.underscore.to_sym
      # If user is trying to access someone else's user actions.
      if @user.class == User
        unless current_user.id === @user.id
          redirect_to root_path, notice: message
        end
      elsif !controller_symbol.nil? && params.has_key?(controller_symbol)
        redirect_to root_path, notice: message unless current_user.id === params[controller_symbol][:user_id].to_i
      end
    end
  end
end