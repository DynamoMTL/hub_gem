require 'active_model/serializer'

module Spree
  module Hub
    class CustomerSerializer < ActiveModel::Serializer
      attributes :id, :email, :sign_in_count, :current_sign_in_at, :last_sign_in_at

      class << self
        def push_it(obj)
          ap payload = ActiveModel::ArraySerializer.new([obj], each_serializer: self, root: 'customer').to_json
          ap Client.push(payload)
        end
      end      

    end
  end
end