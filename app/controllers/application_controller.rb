class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :set_controller, :set_action, :authenticate_user!

  def after_sign_out_path_for resource
    new_user_session_path
  end

  def after_sign_in_path_for resource
    current_user.online!
    ActionCable.server.broadcast "users_status_channel", user_id: current_user.id, sign_in: true
    root_path
  end

  def set_controller
    @users = User.order :email
    @controller = params[:controller]
  end

  def set_action
    @action = action_name
  end

end
