class SearchesController < ApplicationController
  before_action :authenticate_user_or_admin!

  def search
    @range = params[:range]
    @word = params[:word]
    @posts = Post.where("title LIKE ? OR introduction LIKE ?", "%#{@word}%", "%#{@word}%")
    @users = User.where("name LIKE ?", "%#{@word}%")
  end
end