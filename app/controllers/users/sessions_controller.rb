class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "guestuserでログインしました。"
    # エラー発生中。パスをインデックスに変える必要あり、。またlink_toと重複も改善しないといけないかも
  end
end