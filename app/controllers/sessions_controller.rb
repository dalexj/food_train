class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = user.id
    redirect_to root_path, notice: "Logged in as #{user.full_name}"
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
