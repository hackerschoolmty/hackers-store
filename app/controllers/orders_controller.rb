class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :remove_product, :pay, :process_payment]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  def add_product
    if session[:order_id]
      @order = Order.includes(:order_items).find(session[:order_id])
    else
      @order = Order.create!
      session[:order_id] = @order.id
    end
    order_item_exist = @order.order_items.find_by(product_id: params[:product_id])
    if order_item_exist
      order_item_exist.increment!(:quantity)
    else
      @order.order_items.create(product_id: params[:product_id])
    end
    redirect_to cart_path, notice: "Order created successfully" and return
  end

  def remove_product
    # render json: @order
    @order_item = @order.order_items.find(params[:item_id])

    respond_to do |format|
      if @order_item.destroy
        @order.reload
        @order.compute_total
        @order.save
        format.js {}
      else
        format.js {}
      end
    end

  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  def pay
    render layout: false if request.xhr?
  end

  def process_payment

    Conekta.locale = :es
    Conekta.api_key = 'key_7GHCfFiCEFi1FEMhpn2KTw'

    begin

      line_items = []
      @order.order_items.each do |item|
        line_items << {
          "name" => item.product.name,
          "description" => item.product.description,
          "unit_price" => item.unit_price*100,
          "quantity" => item.quantity,
          "sku" => item.product_id,
          "type" => "product-purchase"
        }

      end

      charge = Conekta::Charge.create({
        amount: @order.total*100,
        currency: "MXN",
        description: "Lorem ipsum",
        reference_id: "#{@order.id}-#{current_user.id}-#{Time.now.to_i}",
        card: params[:conektaTokenId],
        details: {
          email: current_user.email,
          line_items: line_items
        }
      })

      if charge.status == 'paid'
        @order.token = charge.id
        @order.paid!
        message = 'Order paid! thank you!'
      else
        @order.failed!
      end


    rescue Conekta::ParameterValidationError => e
      message = e.message
      #alguno de los parámetros fueron inválidos
    rescue Conekta::ProcessingError => e
      message = e.message
      #la tarjeta no pudo ser procesada
    rescue Conekta::Error => e
      message = e.message
      #un error ocurrió que no sucede en el flujo normal de cobros como por ejemplo un auth_key incorrecto
    end


    redirect_to root_path, notice: message

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = if session[:order_id].present?
        Order.find(session[:order_id])
      else
        Order.find(params[:id])
      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :total, :status, :token)
    end
end
