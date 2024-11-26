class AuthenticationController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:login, :logout]
  skip_before_action :authenticate_user, only: [:login, :logout]

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      if user.locked_until && Time.current < user.locked_until
        render json: { error: 'Cuenta bloqueada. Intentalo mas tarde.' }, status: :forbidden 
      elsif user.connected?
        render json: { error: 'Usuario ya conectado en otro dispositivo' }, status: :forbidden
      else
        user.update(connected: true, failed_attempts: 0)
        render json: { message: 'Inicio de sesión exitoso', user_id: user.id, role: user.role, email: user.email, name: user.name }, status: :ok
      end
    else
      handle_failed_attempt(user)
    end
  end
  
  def logout
    user = User.find_by(id: session[:user_id])
    if user
      user.update(connected: false)
      session[:user_id] = nil
      flash[:notice] = 'Cierre de sesión exitoso.'
      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { render json: { message: 'Cierre de sesión exitoso' }, status: :ok }
      end
    else
      flash[:alert] = 'Usuario no encontrado.'
      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { render json: { error: 'Usuario no encontrado.' }, status: :not_found }
      end
    end
  end

  private

  def handle_failed_attempt(user)
    if user
      user.increment!(:failed_attempts)
      if user.failed_attempts >= 3
        user.lock_account!
        flash[:alert] = 'Cuenta bloqueada debido a demasiados intentos fallidos.'
        respond_to do |format|
          format.html { redirect_to login_path }
          format.json { render json: { error: 'Cuenta bloqueada debido a demasiados intentos fallidos.' }, status: :forbidden }
        end
      else
        flash[:alert] = 'Credenciales incorrectas.'
        respond_to do |format|
          format.html { redirect_to login_path }
          format.json { render json: { error: 'Credenciales incorrectas.' }, status: :unauthorized }
        end
      end
    else
      flash[:alert] = 'Usuario no encontrado.'
      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { render json: { error: 'Usuario no encontrado.' }, status: :not_found }
      end
    end
  end
end
