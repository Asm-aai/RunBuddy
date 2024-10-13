class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ADMIN_EMAIL = "admin@example.com"

  def self.guest
    find_or_create_by!(email: ADMIN_EMAIL) do |admin|
      admin.password = ENV['SECRET_KEY']
      admin.name = "管理者"
    end
  end

  def admin_user?
    email == ADMIN_EMAIL
  end

  def create
    admin = Admin.find_by(email: params[:admin][:email])

    if admin&.valid_password?(params[:admin][:password])
      sign_in admin
      redirect_to admin_posts_path, notice: "管理者としてログインしました。"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが無効です。"
      render :new
    end
  end

end
