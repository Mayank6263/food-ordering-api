# frozen_string_literal: true

class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes id, total_amount, status, user_id
end
