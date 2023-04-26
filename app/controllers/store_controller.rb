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

  private

  def store_item
    @store_item ||= StoreItem.find_by!(code: params[:code])
  end

  def store_item_params
    params.require(:store_item).permit(:name, :price)
  end
end
