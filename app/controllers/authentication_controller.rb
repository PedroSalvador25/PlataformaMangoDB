class AuthenticationController < ApplicationController
  layout "login"
  skip_before_action :verify_authenticity_token, only: [:login, :logout]
  skip_before_action :authenticate_user, only: [:login, :logout]

  def login
    result = User.authenticate(params[:email], params[:password])

    if result[:success]
      render json: {
        message: 'Inicio de sesión exitoso',
        user_id: result[:user].id,
        role: result[:user].role,
        email: result[:user].email,
        name: result[:user].name
      }, status: :ok
    else
      render json: { error: result[:error] }, status: determine_status(result[:error])
    end
  end

  def logout
    if User.logout(params[:user_id])
      render json: { message: 'Logout exitoso' }, status: :ok
    else
      render json: { error: 'Usuario no encontrado.' }, status: :not_found
    end
  end

  private

  def determine_status(error_message)
    case error_message
    when 'Cuenta bloqueada. Inténtalo más tarde.'
      :forbidden
    when 'Credenciales incorrectas.'
      :unauthorized
    when 'Cuenta bloqueada debido a demasiados intentos fallidos.'
      :forbidden
    else
      :not_found
    end
  end
end

