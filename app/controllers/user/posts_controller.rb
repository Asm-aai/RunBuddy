class User::PostsController < UserApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy, :new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post, notice: '投稿が成功しました。'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def index
    @posts = Post.all

  end

  def index_only_tag
    @tag = Tag.find(params[:id])
    @posts_only_tag = @tag.posts
    # @posts = Post.tagged_with(params[:tag])  # 例: `params[:tag]`に基づいてフィルタリング
  end

  def show
    @post_user = @post.user
    @comment = Comment.new
  end

  def edit
  end

  def destroy
    @post.delete
    redirect_to my_page_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :address, :hp, :introduction, :user_id, :image, tag_ids: [])
  end

  def authorize_user
    unless @post.user_id == current_user.id
      redirect_back(fallback_location: posts_path, alert: "権限がないため、この操作を実行できません。")
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end
end