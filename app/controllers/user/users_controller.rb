class User::UsersController < UserApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

end