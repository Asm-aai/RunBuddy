class Admin::PostsController < AdminApplicationController
  before_action :set_post, only: [:show, :destroy]

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.page(params[:page])
  end

  def index
    @posts = Post.all.page(params[:page])
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '投稿が削除されました。'
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end
end
