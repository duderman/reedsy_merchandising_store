# frozen_string_literal: true

class CartTotalCalculatorService < ApplicationService
  UnknownItemError = Class.new(StandardError)

  def initialize(cart_items)
    @cart_items = cart_items
  end

  def call
    items.sum(&:total).to_d
  end

  private

  attr_reader :cart_items

  def items
    cart_items.map(&method(:decorate_item))
  end

  def decorate_item(code, quantity)
    store_item_by_code(code).then { CartItemDecorator.new(_1, quantity) }
  end

  def store_item_by_code(code)
    store_items[code] || raise(UnknownItemError, "Unknown item with code: #{code}")
  end

  def store_items
    @store_items ||= StoreItem.where(code: cart_items_codes).index_by(&:code)
  end

  def cart_items_codes
    cart_items.keys
  end
end
