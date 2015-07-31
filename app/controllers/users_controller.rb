class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_info = request.env['omniauth.auth']
  end
  
end
