# frozen_string_literal: true

module Discounts
  module_function

  def discount_value_for(decorated_store_item)
    discount_module_for_code(decorated_store_item.code).discount_value(decorated_store_item)
  end

  def discount_module_for_code(code)
    "Discounts::#{code.downcase.camelize}".safe_constantize || Discounts::Default
  end
end
