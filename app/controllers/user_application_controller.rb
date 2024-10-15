class UserApplicationController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :authorize_user, only: [:edit, :update, :destroy]
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
  def authorize_user
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id]) # コメントを見つける
    unless comment.user_id == current_user.id
      redirect_back(fallback_location: posts_path, alert: "権限がないため、この操作を実行できません。")
    end
  end

  def ensure_guest_user
    if current_user.guest_user?
      flash[:notice] = "ゲストユーザーはプロフィール画面へ遷移できません。"
      redirect_back(fallback_location: root_path)
    end
  end
end