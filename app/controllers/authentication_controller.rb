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
    user = User.find_by(id: params[:user_id])
    if user
      user.update(connected: false)
      render json: { message: 'Logout exitoso' }, status: :ok
    else
      render json: { error: 'Usuario no encontrado.' }, status: :not_found
    end
  end

  private

  def handle_failed_attempt(user)
    if user
      user.increment!(:failed_attempts)
      if user.failed_attempts >= 3
        user.lock_account!
        render json: { error: 'Cuenta bloqueada debido a demasiados intentos fallidos.' }, status: :forbidden
      else
        render json: { error: 'Credenciales incorrectas.' }, status: :unauthorized
      end
    else
      render json: { error: 'Usuario no encontrado.' }, status: :not_found
    end
  end
end
