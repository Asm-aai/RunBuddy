class UserApplicationController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :ensure_guest_user, only: [:my_page]

  layout 'application'

  def my_page
    @my_posts = current_user.posts
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  private
  def ensure_guest_user
    if current_user.guest_user?
      flash[:notice] = "ゲストユーザーはプロフィール画面へ遷移できません。"
      redirect_back(fallback_location: root_path)
    end
  end
end