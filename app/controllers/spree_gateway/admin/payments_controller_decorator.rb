# frozen_string_literal: true

module SpreeGateway
  module Admin
    module PaymentsControllerDecorator
      def create
        Rails.logger.debug "create params: #{params.inspect}\n#############\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n#############\n\n\n"
        invoke_callbacks(:create, :before)
        @payment ||= @order.payments.build(object_params)
        # not only credit card may require source
        if @payment.payment_method.source_required? && (params[:card].present? && params[:card] != 'new')
          @payment.source = @payment.payment_method.payment_source_class.find_by(id: params[:card])
        end
        #   elsif @payment.payment_source.is_a?(Spree::Gateway::FlutterwaveZambiaMobileMoney)
        #     @payment.braintree_token = params[:payment_method_token]
        #     @payment.braintree_nonce = params[:payment_method_nonce]
        #     @payment.source = Spree::FlutterwaveRequest.create!(admin_payment: true)

        begin
          if @payment.save
            invoke_callbacks(:create, :after)
            # Transition order as far as it will go.
            while @order.next; end
            # If "@order.next" didn't trigger payment processing already (e.g. if the order was
            # already complete) then trigger it manually now

            # TODO: : return thus as part of the conditional @order.completed? &&
            @payment.process! if @payment.checkout?
            flash[:success] = flash_message_for(@payment, :successfully_created)

            # Redirect if FLutterwaveZambiaMobileMoney
            if @payment.payment_method.is_a?(Spree::Gateway::FlutterwaveZambiaMobileMoney)
              # redirect_to "https://murmuring-forest-61616.herokuapp.com/#{@payment.payment_source.name}"
              # TODO:: Figure out the correctway to redirect to the payment
              # redirect_to admin_order_payment_path(@payment)

            end
            redirect_to admin_order_payments_path(@order)
          else
            invoke_callbacks(:create, :fails)
            flash[:error] = Spree.t(:payment_could_not_be_created)
            render :new
          end
        rescue Spree::Core::GatewayError => e
          invoke_callbacks(:create, :fails)
          flash[:error] = e.message.to_s
          redirect_to new_admin_order_payment_path(@order)
        end
      end

      def firm_redirect_to(url)
        if request.xhr?
          render js: "window.location = '#{url}'"
        else
          redirect_to url
        end
      end
    end
  end
end

::Spree::Admin::PaymentsController.prepend(::SpreeGateway::Admin::PaymentsControllerDecorator)
