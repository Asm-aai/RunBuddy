class User::UsersController < UserApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts

    if params[:sort] == "created_at_asc"
      @posts = @posts.order(created_at: :asc)
    elsif params[:sort] == "created_at_desc"
      @posts = @posts.order(created_at: :desc)
    elsif params[:sort] == "favorited_desc"
      @posts = @posts.left_joins(:favorites).group('posts.id').order('COUNT(favorites.id) DESC')
    elsif params[:sort] == "comments_desc"
      @posts = @posts.left_joins(:comments).group('posts.id').order('COUNT(comments.id) DESC')
    end
  end
end