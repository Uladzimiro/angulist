module Api
  class GroupsController < BaseController

    private
    
    def permitted_params
      params.permit(group: [:title, :sort_order])
    end

    def begin_of_association_chain
      current_user
    end
  end
end
