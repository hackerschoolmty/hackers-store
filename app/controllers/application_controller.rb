#
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_order
  helper_method :current_order

  def current_order
    load_user_order if user_has_pending_order!
    update_order_user if session[:order_id].present? && order_user_is_empty?
    @current_order ||= order
  end

  private

  def load_user_order
    session[:order_id] = current_user.orders.pending.first.id
  end

  def order
    Order.find_by_id(session[:order_id])
  end

  def update_order_user
    order.update_attribute(:user_id, current_user.id)
  end

  def order_user_is_empty?
    user_signed_in? && order && order.user_id.blank?
  end

  def user_has_pending_order!
    user_signed_in? && current_user.orders.pending.first
  end
end
