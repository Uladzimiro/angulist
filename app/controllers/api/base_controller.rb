module Api
  class BaseController < InheritedResources::Base
    actions :index, :show, :create, :update, :destroy
    respond_to :json
    protect_from_forgery with: :exception

    before_filter :authenticate_user!

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def record_not_found
      render status: 404, json: { error: 'Not Found' }
    end

    def default_serializer_options
      { root: false }
    end

  end
end
