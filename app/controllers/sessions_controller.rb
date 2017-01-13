class SessionsController < Devise::SessionsController

  def destroy
    current_user.offline!
    ActionCable.server.broadcast "users_status_channel", user_id: current_user.id, sign_in: false
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

end
