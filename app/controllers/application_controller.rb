class ApplicationController < ActionController::Base
  before_action :ensure_guest_user, only: [:edit]


  private
  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to my_page_path , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
