class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :index]
  before_action :authenticate_admin!, except: [:top]

  def after_sign_in_path_for(resource)
    about_path
  end

  def after_sign_out_path_for(resource)
    about_path
  end


end
