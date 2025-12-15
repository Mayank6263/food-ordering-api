# frozen_string_literal: true

module PaginationConcern
  extend ActiveSupport::Concern

  included do
    before_action :paginate_attributes, only: :index
  end

  def paginate_attributes
    @model = controller_name.capitalize.classify.constantize
    return for_menu_item if @model == MenuItem

    @result = @model.all.paginate(page: params[:page], per_page: params[:per_page])
    return_page
  end

  def for_menu_item
    restro = Restaurant.find params[:restaurant_id]
    @result = restro.menu_items.all.paginate(page: params[:page], per_page: params[:per_page])
    return_page
  end

  def return_page
    @page = { total_entries: @result.size,
              current_page: @result.current_page,
              total_page: @result.total_pages,
              previous_page: (@result.current_page - 1),
              next_page: (@result.current_page + 1) }
  end
end
