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

    # for search
    query = params[:query]
    @result = model.paginate(page: params[:page], per_page: params[:per_page]) if query.nil?

    #else normal index
    search_result = model.where("name ILIKE ?", "%#{query}%").or(model.where("address ILIKE ?", "%#{query}%"))
    @result = search_result&.paginate(page: params[:page], per_page: params[:per_page])
    page_details
  end

  def menu_list
    restro = Restaurant.find params[:restaurant_id]
    @result = restro.menu_items.order(id: :asc).paginate(page: params[:page], per_page: params[:per_page])
    page_details
  end

  def order_list
    @result = current_user.orders.paginate(page: params[:page], per_page: params[:per_page])
    page_details
  end

  def page_details
    {
      total_entries: @result.count,
      current_page: @result.current_page,
      total_page: @result.total_pages
    }
  end
end
