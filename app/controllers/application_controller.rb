class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :index]
  before_action :authenticate_admin!, except: [:top]
end
