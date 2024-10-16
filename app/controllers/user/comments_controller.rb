class User::CommentsController < UserApplicationController
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def new

  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id

    @comment.total_star = "1"
    @comment.extent_star = "1"
    @comment.clean_star = "1"
    @comment.amenity_star = "1"
    @comment.safety_star = "1"
    @comment.cost_star = "1"
    # 仮データ

    if @comment.save
      redirect_to post_path(@post), notice: 'コメントを投稿しました。'
    else
      Rails.logger.error(@comment.errors.full_messages)
      redirect_back(fallback_location: post_path(@post), alert: 'コメントを入力してください。')
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.all
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id]), notice: 'コメントを削除しました。'
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    @comment.total_star = "1"
    @comment.extent_star = "1"
    @comment.clean_star = "1"
    @comment.amenity_star = "1"
    @comment.safety_star = "1"
    @comment.cost_star = "1"
    # 仮データ

  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.update(comment_params)
      flash[:notice] = "コメントが更新されました。"
      redirect_to post_path(@post)
    else
      flash[:alert] = "コメントの更新に失敗しました。"
      render :edit
    end
  end

  private
  def comment_params
    # params.require(:comment).permit(:comment, :total_star, :extent_star, :clean_star, :amenity_star, :safety_star, :cost_star, :user_id, :post_id)
    params.require(:comment).permit(:comment, :user_id, :post_id, :total_star, :extent_star, :clean_star, :amenity_star, :safety_star, :cost_star)
  end

  def authorize_user
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
    unless comment.user_id == current_user.id
      redirect_back(fallback_location: posts_path, alert: "権限がないため、この操作を実行できません。")
    end
  end
end