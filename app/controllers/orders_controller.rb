#
class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :remove_product,
                                   :pay, :process_payment]
  before_action :set_order_from_session_or_new, only: [:add_product]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  def add_product
    order_item_exist = @order.order_items.find_by(
      product_id: params[:product_id])
    if order_item_exist
      order_item_exist.increment!(:quantity)
    else
      @order.order_items.create(product_id: params[:product_id])
    end
    redirect_to cart_path, notice: 'Product added' and return
  end

  def remove_product
    @order_item = @order.order_items.find(params[:item_id])
    respond_to do |format|
      @order_item.destroy
      @order.reload
      @order.compute_total
      @order.save
      format.js {}
    end
  end

  def show
  end

  def pay
    render layout: false if request.xhr?
  end

  def process_payment
    line_items = []
    @order.order_items.each { |item| line_items << item_hash(item) }

    @cp = ConektaPayment.new(
      order: @order, line_items: line_items, current_user: current_user,
      conektaTokenId: params[:conektaTokenId]
    )
    session.delete(:order_id) if @cp.status

    redirect_to root_path, notice: @cp.message
  end

  private

  def set_order
    @order = if session[:order_id].present?
               Order.find(session[:order_id])
             else
               Order.find(params[:id])
             end
  end

  def order_params
    params.require(:order).permit(:user_id, :total, :status, :token)
  end

  def set_order_from_session_or_new
    if session[:order_id]
      @order = Order.includes(:order_items).find(session[:order_id])
    else
      @order = Order.create!
      session[:order_id] = @order.id
    end
  end

  def item_hash(item)
    { 'name' => item.product.name, 'description' => item.product.description,
      'unit_price' => item.unit_price * 100, 'quantity' => item.quantity,
      'sku' => item.product_id, 'type' => 'product-purchase' }
  end
end
