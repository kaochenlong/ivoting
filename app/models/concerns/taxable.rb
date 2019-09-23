module Taxable
  extend ActiveSupport::Concern

  included do
  end

  def total_price_with_tax
    (total_price * 1.05).floor
  end

  module ClassMethods
  end
end