# frozen_string_literal: true

class StoreItem < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  def self.codes
    all.pluck(:code)
  end
end
