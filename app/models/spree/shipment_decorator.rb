Spree::Shipment.send(:include, Spree::Hub::AutoPush)
Spree::Shipment.hub_serializer = "Spree::Hub::ShipmentSerializer"
Spree::Shipment.json_root_name = 'shipments'


Spree::Shipment.class_eval do
  def push_to_hub
  end
end
