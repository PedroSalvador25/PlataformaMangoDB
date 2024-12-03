class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  layout "application"
  allow_browser versions: :modern
  before_action :authenticate_user
  helper_method :current_user

  private

  def authenticate_user
    unless session[:user_id]
      respond_to do |format|
        format.html do
          redirect_to login_path
        end
        format.json do
          render json: { error: 'No autenticado. Por favor inicia sesión.' }, status: :unauthorized
        end
      end
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "No estás autorizado para realizar esta acción."
    redirect_to(request.referrer || root_path)
  end
  
end

