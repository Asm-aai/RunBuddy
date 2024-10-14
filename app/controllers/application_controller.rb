class ApplicationController < ActionController::Base
  def authenticate_user_or_admin!
    unless user_signed_in? || admin_signed_in?
      redirect_to new_user_session_path, alert: "ログインしてください。"
    end
  end
end
