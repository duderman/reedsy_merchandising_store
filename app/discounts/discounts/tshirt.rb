# frozen_string_literal: true

module Discounts
  module Tshirt
    MANY_TSHIRTS_DISCOUNT = 0.3
    MINIMUM_TSHIRTS_FOR_DISCOUNT = 3

    module_function

    def discount_value(decorated_store_item)
      return 0.0 if decorated_store_item.quantity < MINIMUM_TSHIRTS_FOR_DISCOUNT

      decorated_store_item.total * MANY_TSHIRTS_DISCOUNT
    end
  end
end
