class ApplicationController < ActionController::Base
  before_action :ensure_guest_user, only: [:edit]


  private
  def ensure_guest_user
    if current_user.guest_user?
      flash[:notice] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_back(fallback_location: root_path)
    end
  end
end
