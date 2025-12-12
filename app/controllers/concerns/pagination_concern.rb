# frozen_string_literal: true

module PaginationConcern
  extend ActiveSupport::Concern

  def paginate_attributes
    @model = controller_name.capitalize.classify.constantize
    @result = @model.all.paginate(page: params[:page], per_page: params[:per_page])
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
