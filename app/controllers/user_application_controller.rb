class UserApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :index, :about]
  layout 'application'

  def my_page
    @my_posts = current_user.posts
  end
end
