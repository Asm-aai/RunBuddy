class AdminApplicationController < ApplicationController
  before_action :authenticate_admin!, except: [:top, :about]
  layout 'application'

  def authenticate_admin!
    redirect_to new_user_session_path unless admin_signed_in?
  end
end
