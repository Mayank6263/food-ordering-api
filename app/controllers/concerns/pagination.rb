# frozen_string_literal: true

module Pagination
  extend ActiveSupport::Concern

  included do
    before_action :paginate_attributes, only: :index
  end

  def paginate_attributes
    model = controller_name.capitalize.classify.constantize

    return menu_list if model == MenuItem
    return order_list if model == Order

    @result = model.search_restro(params[:query]).paginate(page: params[:page], per_page: params[:per_page])
    return_page
  end

  def menu_list
    restro = Restaurant.find params[:restaurant_id]
    @result = restro.menu_items.paginate(page: params[:page], per_page: params[:per_page])
    return_page
  end

  def order_list
    @result = current_user.orders.paginate(page: params[:page], per_page: params[:per_page])
    return_page
  end

  def return_page
    {
      total_entries: @result.count,
      current_page: @result.current_page,
      total_page: @result.total_pages
    }
  end
end
