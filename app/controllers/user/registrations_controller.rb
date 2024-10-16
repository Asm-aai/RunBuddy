# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def destroy
    super do
      redirect_to new_user_registration_path and return
    end
  end

  def after_update_path_for(resource)
    my_page_path
  end

  # def edit
  #   @user = current_user
  #   super()
  # end




  def after_sign_in_path_for(resource)
    my_page_path
  end

  private
  def authorize_user!
    user_id = params[:format] || current_user.id
    @user = User.find(user_id)
    unless @user == current_user
      redirect_back(fallback_location: posts_path, alert: "権限がないため、この操作を実行できません。")
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

end
