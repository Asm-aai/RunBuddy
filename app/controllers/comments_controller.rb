class CommentsController < ApplicationController
  def new

  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to post_path(@post), notice: 'コメントを投稿しました。'
    else
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
    params.require(:comment).permit(:comment, :total_star, :extent_star, :clean_star, :amenity_star, :safety_star, :cost_star, :user_id, :post_id)
  end
end