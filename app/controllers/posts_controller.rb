class PostsController < UserApplicationController
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
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title, :address, :hp, :introduction, :user_id, :image)
  end
end