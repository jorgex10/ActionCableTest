class UsersController < ApplicationController

  def index
    @users = User.search_with params[:query]
  end

end
