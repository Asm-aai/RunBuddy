class User::FavoritesController < UserApplicationController
  before_action :set_post, only: [:create, :destroy]

  def create
    @post_favorite = Favorite.new(user_id: current_user.id, post_id: params[:post_id])
    @post_favorite.save
    # redirect_to request.referer
  end

  def destroy
    @post_favorite = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
    @post_favorite.destroy
    # redirect_to request.referer
  end

  def index
    @posts = Post.joins(:favorites).where(favorites: { user_id: current_user.id })

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

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

end
