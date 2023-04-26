# frozen_string_literal: true

class CartItemDecorator < ApplicationDecorator
  attributes %i[code name price]

  def initialize(store_item, quantity)
    @store_item = store_item
    @quantity = quantity
  end

  def total_with_discount
    total - Discounts.discount_value_for(self)
  end

  def total
    price * quantity
  end

  def quantity
    @quantity.to_i
  end

  private

  attr_reader :store_item

  object :store_item
end
