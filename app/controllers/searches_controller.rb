class SearchesController < ApplicationController
  before_action :authenticate_user_or_admin!

  def search
    @word = params[:word]
    @posts = Post.where("is_active = :active AND (title LIKE :word OR introduction LIKE :word OR address LIKE :word OR hp LIKE :word)", active: true, word: "%#{@word}%").page(params[:page])
    @users = User.where("name LIKE ?", "%#{@word}%")
    @tags = Tag.where("name LIKE ?", "%#{@word}%")

    if params[:sort] == "created_at_asc"
      @posts = @posts.order(created_at: :asc)
    elsif params[:sort] == "created_at_desc"
      @posts = @posts.order(created_at: :desc)
    elsif params[:sort] == "favorited_desc"
      @posts = @posts.left_joins(:favorites).group('posts.id').order('COUNT(favorites.id) DESC')
    elsif params[:sort] == "comments_desc"
      @posts = @posts.left_joins(:comments).group('posts.id').order('COUNT(comments.id) DESC')
    elsif params[:sort] == "star_at_desc"
      # @posts = @posts.order(average_total_star: :desc)
      @posts = @posts.left_joins(:comments).group('posts.id').reorder(Arel.sql('COALESCE(AVG(comments.total_star), 0) DESC'))
    end
  end
end