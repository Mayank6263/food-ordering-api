# frozen_string_literal: true

module PaginationConcern
  extend ActiveSupport::Concern

  included do
    before_action :paginate_attributes, only: :index
  end

  def paginate_attributes
    @model = controller_name.capitalize.classify.constantize

    return menu_list if @model == MenuItem
    return order_list if @model == Order

    @result = @model.all.paginate(page: params[:page], per_page: params[:per_page])
    return_page
  end

  def menu_list
    restro = Restaurant.find params[:restaurant_id]
    @result = restro.menu_items.paginate(page: params[:page], per_page: params[:per_page])
    return_page
  end

  def order_list
    @result = current_user.orders.all.paginate(page: params[:page], per_page: params[:per_page])
    return_page
  end

  # def validate_current_page
  #   byebug
  #   @page[:next_page] = 0 if @page[:next_page] > @page[:total_page]
  #   @result = "Current page should not be greater than total" if @page[:current_page] > @page[:total_page] 
  # end

  def return_page
    @page = { total_entries: @result.count,
              current_page: @result.current_page,
              total_page: @result.total_pages,
              previous_page: (@result.current_page - 1),
              next_page: (@result.current_page + 1) }

    # validate_current_page
    return @page
  end
end
