class AdminApplicationController < ActionController::Base
  before_action :authenticate_admin!, except: [:top, :about, :index]
  layout 'application'
end
