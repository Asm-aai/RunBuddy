class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to users_guest_sign_in_path, notice: "guestuserでログインしました。"
  end
end