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
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

end
