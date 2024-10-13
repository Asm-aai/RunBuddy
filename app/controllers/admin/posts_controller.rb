class Admin::PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]

  def show
  end

  def index
    @posts = Post.all
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '投稿が削除されました。'
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
