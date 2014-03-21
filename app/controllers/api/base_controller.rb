module Api
  class BaseController < InheritedResources::Base
    protect_from_forgery with: :exception

    before_filter :authenticate_user!

  end
end
