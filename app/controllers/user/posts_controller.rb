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
      redirect_to @post, notice: '投稿が成功しました。'
    else
      flash[:error] = @post.errors.full_messages.join("\n")
      render :new
    end
  end

  def update
    if @post.save
      redirect_to post_path(@post), notice: '投稿が更新されました。'
    else
      flash[:error] = @post.errors.full_messages.join("\n")
      render :edit
    end
  end


  def process_image_analysis
    # Google Cloud Vision API の設定
    require "google/cloud/vision"
    image_annotator = Google::Cloud::Vision.image_annotator do |config|
      config.credentials = ENV["GOOGLE_API_KEY"]
    end

    # APIに画像を解析リクエスト送信
    results = []
    images = []
    params[:post][:images].each do |image|
      pp image.tempfile.path
      images.push(image.tempfile.path)
    end
    images.each do |image|
      response = image_annotator.label_detection(image: image) # 例としてlabel_detectionを使用
      results += response.responses.flat_map(&:label_annotations).map(&:description)
    end
    pp results
    # 解析結果からタグIDを取得する処理（API連携の部分は省略）
    tag_ids = fetch_tags_from_results(results)

    render json: { tag_ids: tag_ids }
  rescue Google::Cloud::Error => e
    Rails.logger.error("画像認識エラー: #{e.message}")
    render json: { error: "Image analysis failed." }, status: :unprocessable_entity
  end

  def process_introduction_analysis
    tag_ids = []
    introduction_text = params[:post][:introduction]

    # タグのnameがintroduction_textに含まれるかを部分一致で検索
    Tag.all.each do |tag|
      tag_name = tag.name

      # タグ名を意味的に分割して、紹介文に一致するか確認
      tag_name.scan(/([一-龯々]+|[ァ-ヴー]+|[A-Za-z0-9]+|[、。])/).each do |match|
        pp match
        if introduction_text.include?(match[0])
          tag_ids << tag.id
          break  # 一度一致すれば、そのタグを追加して次のタグへ
        end
      end
    end

    tag_ids.uniq!
    render json: { tag_ids: tag_ids }
  end

  def fetch_tags_from_results(results)
    tag_ids = []
    results.each do |label|
      matching_tags = Tag.where("english_word LIKE ?", "%#{label}%")
      tag_ids.concat(matching_tags.pluck(:id)) if matching_tags.any?
    end
    tag_ids.uniq
    # 重複を排除
  end

  # def fetch_tags_from_introduction(results)
  #   tag_ids = []
  #   introduction_text = params[:post][:introduction]

  #   # タグのnameがintroduction_textに含まれるかを部分一致で検索
  #   Tag.all.each do |tag|
  #     if introduction_text.include?(tag.name) # 紹介文内にtag.nameが含まれているか確認
  #       tag_ids << tag.id
  #     end
  #   end

  #   tag_ids.uniq!
  #   render json: { tag_ids: tag_ids }
  # end

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

  def authorize_user
    unless @post.user_id == current_user.id
      redirect_back(fallback_location: posts_path, alert: "権限がないため、この操作を実行できません。")
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end
end