class SearchesController < ApplicationController
  before_action :authenticate_user_or_admin!

  def search
    @word = params[:word]
    @posts = Post.where("title LIKE ? OR introduction LIKE ? OR address LIKE ? OR hp LIKE ?", "%#{@word}%", "%#{@word}%", "%#{@word}%", "%#{@word}%").page(params[:page])
    @users = User.where("name LIKE ?", "%#{@word}%").page(params[:page])
    @tags = Tag.where("name LIKE ?", "%#{@word}%")

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