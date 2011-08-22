class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  before_filter :require_signed_in

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_signed_in
    unless current_user
      puts "NOT SIGNED IN"
      redirect_to root_path, :notice => "You must be signed in!"
    end
  end

end
