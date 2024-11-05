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
      analyze_images(@post.images)
      redirect_to @post, notice: '投稿が成功しました。'
    else
      flash[:error] = @post.errors.full_messages.join("\n")
      render :new
    end
  end

  def update
    if @post.update(post_params)
      analyze_images(@post.images)
      redirect_to post_path(@post), notice: '投稿が更新されました。'
    else
      flash[:error] = @post.errors.full_messages.join("\n")
      render :edit
    end
  end

  def index
    @posts = Post.where(is_active: true).page(params[:page])

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

  def tag
    @tag = Tag.find(params[:id])
    @posts_only_tag = @tag.posts.where(is_active: true).page(params[:page])

    if params[:sort] == "created_at_asc"
      @posts_only_tag = @posts_only_tag.order(created_at: :asc)
    elsif params[:sort] == "created_at_desc"
      @posts_only_tag = @posts_only_tag.order(created_at: :desc)
    elsif params[:sort] == "favorited_desc"
      @posts_only_tag = @posts_only_tag.left_joins(:favorites).group('posts.id').order('COUNT(favorites.id) DESC')
    elsif params[:sort] == "comments_desc"
      @posts_only_tag = @posts_only_tag.left_joins(:comments).group('posts.id').order('COUNT(comments.id) DESC')
    end

  end

  def show
    @post_user = @post.user
    @comment = Comment.new
    @comments = @post.comments.page(params[:page])
  end

  def edit
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '投稿が削除されました。'
  end

  def tag_index
    @tags = Tag.all
  end

  def inactive_index
    @inactive_posts = Post.where(is_active: false).page(params[:page])

    if params[:sort] == "created_at_asc"
      @inactive_posts = @inactive_posts.order(created_at: :asc)
    elsif params[:sort] == "created_at_desc"
      @inactive_posts = @inactive_posts.order(created_at: :desc)
    elsif params[:sort] == "favorited_desc"
      @inactive_posts = @inactive_posts.left_joins(:favorites).group('posts.id').order('COUNT(favorites.id) DESC')
    elsif params[:sort] == "comments_desc"
      @inactive_posts = @inactive_posts.left_joins(:comments).group('posts.id').order('COUNT(comments.id) DESC')
    end

  end

  private
  def post_params
    params.require(:post).permit(:title, :address, :hp, :introduction, :user_id, :is_active, tag_ids: [], images: [])
  end
  
  
  def process_image_analysis(images)
    # Google Cloud Vision APIのセットアップ
    protect_from_forgery
    # CSRFのエラー対策
    require "google/cloud/vision"
    image_annotator  = Google::Cloud::Vision.image_annotator do | config |
      config.credentials = ENV["GOOGLE_API_KEY"]
    end
    
    # 画像認証APIへのリクエストを準備
    return if images.blank?

    form_data = { images: images }
      
    response = RestClient.post('https://vision.googleapis.com/v1/images:annotate?key=#{ENV["GOOGLE_API_KEY"]}', form_data)

    # 取得したタグIDを選択
    tag_ids = JSON.parse(response.body)['tag_ids'] # APIのレスポンスからタグIDを取得
    @post.tag_ids = tag_ids # 取得したタグIDを投稿に関連付ける
    @post.save # タグの更新を保存
  rescue RestClient::ExceptionWithResponse => e
    Rails.logger.error("画像認証エラー: #{e.response}")
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