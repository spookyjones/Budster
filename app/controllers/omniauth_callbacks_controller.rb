class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)

    @user = User.from_omniauth(request.env["omniauth.auth"])
    @koala = User.koala(request.env['omniauth.auth']['credentials'])

    if @user.persisted?
      if @user.email = ""
        @user.update_attribute :email, @koala['email']
      end
      @friendlist_uids = ""
      @friendlist = @koala['friends']
      @friendlist['data'].each do |f|
        @friendlist_uids = @friendlist_uids + f['id'] + ","
      end
      @user.update_attribute :info, @friendlist_uids
      sign_in @user
      redirect_to facebook_friends_path
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
  private
  
end