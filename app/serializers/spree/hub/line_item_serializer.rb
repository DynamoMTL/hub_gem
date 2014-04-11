require 'active_model/serializer'

module Spree
  module Hub
    class LineItemSerializer < ActiveModel::Serializer
      attributes :product_id, :name, :quantity, :price

      has_one :variant, serializer: Spree::Hub::VariantSerializer

      def product_id
        object.variant.sku
      end

      def price
        object.price.to_f
      end

    end
  end
end
