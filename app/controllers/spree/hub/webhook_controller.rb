module Spree
  module Hub
    class WebhookController < ActionController::Base
      before_filter :authorize

      def consume
        called_hook = params[:path]
        webhook_body = request.body.read
        handler = Handler::Base.build_handler(called_hook, webhook_body)
        responder = handler.process
        Rails.logger.warn(responder) && Rails.logger.warn(handler) if responder.nil?
        render json: responder, root: false, status: responder.code
      end

      protected
      def authorize
        unless request.headers['HTTP_X_HUB_STORE'] == Spree::Hub::Config[:hub_store_id] && request.headers['HTTP_X_HUB_TOKEN'] == Spree::Hub::Config[:hub_token]
          render status: 401, json: { text: 'unauthorized' }
          return false
        end
      end
    end
  end
end
