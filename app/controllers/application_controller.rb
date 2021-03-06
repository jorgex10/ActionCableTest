class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :set_controller, :set_action, :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for resource
    new_user_session_path
  end

  def after_sign_in_path_for resource
    current_user.online!
    ActionCable.server.broadcast "users_status_channel", room_ids: current_user.rooms.map(&:id), sign_in: true
    root_path
  end

  def set_controller
    @controller = params[:controller]
    @own_rooms = current_user.rooms if user_signed_in?
  end

  def set_action
    @action = action_name
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :photo])
  end

end
