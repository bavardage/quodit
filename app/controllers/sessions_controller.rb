class SessionsController < ApplicationController

  skip_before_filter :require_signed_in, :only => [:create]

  def create
    auth = request.env["omniauth.auth"]
    user = User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:token] = auth["credentials"]["token"]
    redirect_to user_path(user), :notice => "Signed in!"
  end

  def destroy
    puts "DESTROYING SESSION"
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
