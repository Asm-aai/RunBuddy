class Admin::SessionsController < Devise::SessionsController

  protected
  def after_sign_out_path_for(resource)
    about_path
  end
end
