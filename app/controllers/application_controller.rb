class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_order

  def current_order

    if user_signed_in? && current_user.orders.pending.first
      session[:order_id] = current_user.orders.pending.first.id
    end

    unless session[:order_id].blank?
      order = Order.find(session[:order_id])
      if user_signed_in? && order && order.user_id.blank?
        order.update_attribute(:user_id, current_user.id)
      end
      order
    end

  end
  helper_method :current_order
end
