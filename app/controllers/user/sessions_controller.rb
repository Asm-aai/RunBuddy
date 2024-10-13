# frozen_string_literal: true
class User::SessionsController < Devise::SessionsController

  def create
    user = User.find_by(email: params[:user][:email])
    admin = Admin.find_by(email: params[:user][:email])

    if user&.valid_password?(params[:user][:password])
      sign_in user
      redirect_to my_page_path
    elsif admin&.valid_password?(params[:user][:password])
      sign_in admin
      redirect_to admin_posts_path, notice: "管理者としてログインしました。"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが無効です。"
      render :new
    end
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path, notice: "guestuserでログインしました。"
  end

  protected
  def after_sign_in_path_for(resource)
    my_page_path
  end

  def after_sign_out_path_for(resource)
    about_path
  end
end
