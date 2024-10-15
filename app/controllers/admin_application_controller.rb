class AdminApplicationController < ApplicationController
  before_action :authenticate_admin!, except: [:top, :about]
  layout 'application'

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to new_user_session_path, alert: "権限がないため、この操作を実行できません。"
    end
  end
end