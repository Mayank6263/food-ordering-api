# frozen_string_literal: true

class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_amount, :status, :user_id
end
