class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pagy::Backend
  include LayoutByUser

  private

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
end
