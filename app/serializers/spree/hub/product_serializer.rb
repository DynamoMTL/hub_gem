require 'active_model/serializer'

module Spree
  module Hub
    class ProductSerializer < ActiveModel::Serializer

      attributes :id, :name, :sku, :description, :price, :cost_price,
                 :available_on, :permalink, :meta_description, :meta_keywords,
                 :shipping_category
      attributes :created_at, :updated_at
      attributes :taxons, :options, :properties, :images

      has_many :variants, serializer: Spree::Hub::VariantSerializer
      has_many :images, serializer: Spree::Hub::ImageSerializer

      def id
        object.sku
      end

      def price
        object.price.to_f
      end

      def cost_price
        object.cost_price.to_f
      end

      def available_on
        object.available_on.try :iso8601
      end

      def created_at
        object.created_at.try :iso8601
      end

      def updated_at
        object.updated_at.try :iso8601
      end

      def permalink
        object.permalink
      end

      def shipping_category
        object.shipping_category.name
      end

      def properties
        keys = object.properties.map(&:name)
        keys.inject({}) {|memo, obj| memo[obj] = object.property(obj); memo;}
      end

      def taxons
        object.taxons.collect {|t| t.ancestors.inject([]){|m,o|m<<o.name}}
      end

      def options
        object.option_types.pluck(:name)
      end

    end
  end
end
