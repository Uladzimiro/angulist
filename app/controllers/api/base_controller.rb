module Api
  class BaseController < ActionController::Base
    protect_from_forgery with: :exception

    before_filter :authenticate_user!

  end
end
