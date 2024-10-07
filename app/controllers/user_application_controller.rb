class UserApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :index, :about]
  layout 'application'
end
