# frozen_string_literal: true

unless Enumerable.method_defined?(:filter_map)
  module Enumerable
    def filter_map(&block)
      map(&block).compact
    end
  end
end
