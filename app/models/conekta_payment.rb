#
class ConektaPayment
  attr_reader :message
  attr_reader :status

  def initialize(args = {})
    @order = args[:order]
    @line_items = args[:line_items]
    @current_user = args[:current_user]
    @conekta_token_id = args[:conektaTokenId]
  end

  def pay
    if conekta.status == 'paid'
      update_order
      @status = true
    else
      @status = false
      @order.failed!
    end
  rescue Conekta::ParameterValidationError => e
    @message = e.message
    @status = false
    # alguno de los parametros fueron invalidos
  rescue Conekta::ProcessingError => e
    @message = e.message
    @status = false
    # la tarjeta no pudo ser procesada
  rescue Conekta::Error => e
    @message = e.message
    @status = false
    # un error ocurrio que no sucede en el flujo normal de cobros
    # como por ejemplo un auth_key incorrecto
  end

  def conekta
    Conekta.locale = :es
    Conekta.api_key = 'key_7GHCfFiCEFi1FEMhpn2KTw'
    Conekta::Charge.create(
      amount: @order.total * 100, currency: 'MXN', description: 'Lorem ipsum',
      reference_id: "#{@order.id}-#{@current_user.id}-#{Time.now.to_i}",
      card: @conekta_token_id,
      details: { email: @current_user.email, line_items: @line_items })
  end

  def update_order
    @order.token = charge.id
    @order.paid!
    @message = 'Order paid! thank you!'
    @order.send_confirmation
  end
end
