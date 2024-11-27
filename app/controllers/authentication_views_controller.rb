class AuthenticationViewsController < ApplicationController
    skip_before_action :authenticate_user, only: [:login, :logout]
  
    def login
      if request.get?
        render "users/login"
      elsif request.post?
        user = User.find_by(email: params[:email])
        
        if user&.locked_until && Time.current < user.locked_until
          flash[:alert] = 'Cuenta bloqueada. Inténtalo más tarde.'
          redirect_to login_path
        elsif user&.authenticate(params[:password])
          if user.connected?
            flash[:alert] = 'Usuario ya conectado en otro dispositivo.'
            redirect_to login_path
          else
            user.update(connected: true, failed_attempts: 0)
            session[:user_id] = user.id
            flash[:notice] = 'Inicio de sesión exitoso.'
            redirect_to root_path
          end
        else
          handle_failed_attempt(user)
        end
      end
    end
  
    def logout
      user = User.find_by(id: session[:user_id])
      if user
        user.update(connected: false)
        session[:user_id] = nil
        flash[:notice] = 'Cierre de sesión exitoso.'
      else
        flash[:alert] = 'Usuario no encontrado.'
      end
      redirect_to login_path
    end
  
    private
  
    def handle_failed_attempt(user)
      if user
        user.increment!(:failed_attempts)
        if user.failed_attempts >= 3
          user.lock_account!
          flash[:alert] = 'Cuenta bloqueada debido a demasiados intentos fallidos.'
        else
          flash[:alert] = 'Credenciales incorrectas.'
        end
      else
        flash[:alert] = 'Usuario no encontrado.'
      end
      redirect_to login_path
    end
  end
  
  