class PaymentProcessor
  def initialize(service)
    @service = service
  end

  def create_checkout_session(success_url:, cancel_url:)
    session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: [ {
        price_data: {
          currency: "brl",
          product_data: {
            name: @service.title
          },
          unit_amount: (@service.price * 100).to_i
        },
        quantity: 1
      } ],
      mode: "payment",
      success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_url,
    )
  end
end
