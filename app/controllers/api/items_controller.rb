module Api
  class ItemsController < BaseController

    private
    
    def permitted_params
      params.permit(item: [:group_id, :title, :priority, :complete_on, :completed, :sort_order])
    end

    def resource
      @item ||= end_of_association_chain.joins(:group).where(groups: { user_id: current_user.id }).first
      raise ActiveRecord::RecordNotFound if @item.nil?
      @item = Item.find(@item.id) #fix to solve ReadOnly issue
    end

    def collection
      if params[:group_id]
        @items ||= end_of_association_chain.joins(:group).where(group_id: params[:group_id], groups: {user_id: current_user.id})
      else
        @items ||= end_of_association_chain.joins(:group).where(groups: {user_id: current_user.id})
      end
    end
  end
end
