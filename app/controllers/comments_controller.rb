class CommentsController < ApplicationController
  def new

  end

  def create
    @post = Post.find(params[:post_id])

    if @post.nil?
      redirect_back(fallback_location: posts_path, alert: '投稿が見つかりません。')
      return
    end

    @comment = current_user.comments.new(comment_params)

    @comment.total_star = "1"
    @comment.extent_star = "1"
    @comment.clean_star = "1"
    @comment.amenity_star = "1"
    @comment.safety_star = "1"
    @comment.cost_star = "1"

    if @comment.save
      redirect_to post_path(@post), notice: 'コメントを投稿しました。'
    else
      Rails.logger.error(@comment.errors.full_messages)
      redirect_back(fallback_location: post_path(@post), alert: 'コメントの投稿に失敗しました。')
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.all
  end

  def destroy

  end

  def edit

  end

  def update

  end

  private
  def comment_params
    # params.require(:comment).permit(:comment, :total_star, :extent_star, :clean_star, :amenity_star, :safety_star, :cost_star, :user_id, :post_id)
    params.require(:comment).permit(:comment, :user_id, :post_id, :total_star, :extent_star, :clean_star, :amenity_star, :safety_star, :cost_star)
  end
end