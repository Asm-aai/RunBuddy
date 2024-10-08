class UserApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about, :show]
  layout 'application'

  def my_page
    @my_posts = current_user.posts
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
end