# frozen_string_literal: true

class StoreController < ApplicationController
  def index
    render json: StoreItem.all
  end

  def update
    if store_item.update(store_item_params)
      render json: store_item
    else
      render json: { errors: store_item.errors }, status: :unprocessable_entity
    end
  end

  def total
    total = CartTotalCalculatorService.new(cart_items)
    render json: { total: total.call }
  rescue CartTotalCalculatorService::UnknownItemError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def store_item
    @store_item ||= StoreItem.find_by!(code: params[:code])
  end

  def store_item_params
    params.require(:store_item).permit(:name, :price)
  end

  def cart_items
    params.require(:cart).permit(items: StoreItem.codes).to_h.fetch(:items, {})
  end
end
