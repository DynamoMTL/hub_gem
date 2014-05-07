Spree::Order.send(:include, Spree::Hub::AutoPush)
Spree::Order.hub_serializer = "Spree::Hub::OrderSerializer"
Spree::Order.json_root_name = 'orders'

Spree::Order.class_eval do
  def push_to_hub
    return unless self.line_items.count > 0
    Spree::Hub::Client.push(serialized_payload)
  end
  def serialized_payload
    ActiveModel::ArraySerializer.new(
      [self],
      each_serializer: self.class.hub_serializer.constantize,
      root: order.completed_at.present? ? self.class.json_root_name : 'carts'
    ).to_json
  end
end
