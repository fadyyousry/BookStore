module Stripe
    class PaymentIntentEventHandler
        def call(event)
            begin
                method = "handle_" + event.type.tr('.', '_')
                self.send method, event
            rescue JSON::ParserError => e
                Rails.logger.debug e.message
            rescue NoMethodError => e
                Rails.logger.debug e.message
            end
        end

        def handle_payment_intent_payment_failed(event)

        end

        def handle_payment_intent_succeeded(event)
            user = User.find_by(customer_id: event[:data][:object][:customer])
            user.sales.where(status: 'In Progress').update_all(status: 'Completed')
        end
    end
end