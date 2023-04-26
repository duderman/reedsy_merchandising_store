# frozen_string_literal: true

class StoreController < ApplicationController
  def index
    render json: StoreItem.all
  end
end
