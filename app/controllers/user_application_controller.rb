class UserApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :authorize_user, only: [:edit, :update, :destroy]

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
    unless params(:id).to_i == current_user.id
      redirect_back(fallback_location: posts_path, alert: "権限がないため、この操作を実行できません。")
    end
  end
end