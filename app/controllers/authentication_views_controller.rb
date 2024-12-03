class AuthenticationViewsController < ApplicationController
  layout "login"
  skip_before_action :authenticate_user, only: [:login, :logout]

  def login
    if request.get?
      render "users/login"
    elsif request.post?
      result = User.authenticate(params[:email], params[:password])

      if result[:success]
        session[:user_id] = result[:user].id
        redirect_to root_path, notice: 'Inicio de sesión exitoso.'
      else
        flash[:alert] = result[:error]
        redirect_to login_path
      end
    end
  end

  def logout
    User.logout(session[:user_id])
    session[:user_id] = nil
    redirect_to login_path, notice: 'Cierre de sesión exitoso.'
  end
end




  