class Users::SessionsController < Devise::SessionsController
  def show
    @user = User.find(pasams[:id])
  end
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to my_page_path, notice: "guestuserでログインしました。"
  end
end