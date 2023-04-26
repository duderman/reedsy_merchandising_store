# frozen_string_literal: true

module Discounts
  module Mug
    MUGS_PER_PERCENTAGE_STEP = 10
    PERCENTAGE_STEP = 2
    MAX_DISCOUNT = 0.3

    module_function

    # 2% step for every 10 mugs up to 30%
    def discount_value(decorated_cart_item)
      discount_multiplier = decorated_cart_item.quantity / MUGS_PER_PERCENTAGE_STEP
      discount = discount_multiplier * PERCENTAGE_STEP / 100.0
      decorated_cart_item.total * [discount, MAX_DISCOUNT].min
    end
  end
end
