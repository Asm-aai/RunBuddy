class UserApplicationController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :ensure_guest_user, only: [:new]

  layout 'application'

  def my_page
    @my_posts = current_user.posts

    if params[:sort] == "created_at_asc"
      @my_posts = @my_posts.order(created_at: :asc)
    elsif params[:sort] == "created_at_desc"
      @my_posts = @my_posts.order(created_at: :desc)
    elsif params[:sort] == "favorited_desc"
      @my_posts = @my_posts.left_joins(:favorites).group('posts.id').order('COUNT(favorites.id) DESC')
    elsif params[:sort] == "comments_desc"
      @my_posts = @my_posts.left_joins(:comments).group('posts.id').order('COUNT(comments.id) DESC')
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts

  end

  private
  def ensure_guest_user
    if current_user.guest_user?
      flash[:notice] = "ゲストユーザーは権限がありません。"
      redirect_back(fallback_location: root_path)
    end
  end
end