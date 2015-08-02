require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'GET #index' do
    it 'should return all orders' do
      create :order
      get :index
      expect(assigns(:orders)).to have(1).items
    end
  end

  describe 'POST #add_product' do
    before do
      @order = create :order
      session[:order_id] = @order.id
      product = create :product
      post :add_product, product_id: product.id
    end

    it 'should add a product to an order' do
      @order.reload
      expect(@order.order_items.count).to eq 1
    end

    it 'should redirect to cart path after adding a product' do
      expect(response).to redirect_to cart_path
    end
  end

  describe 'POST #remove_product' do
    before do
      @oi = create(:order_item)
      @order = @oi.order
      session[:order_id] = @order.id
      post :remove_product, format: :js, item_id: @oi.product_id
    end

    it 'should remove a product from an order' do
      @order.reload
      expect(@order.order_items.count).to eq 0
    end

    it 'should recalculate order total' do
      @order.reload
      expect(@order.total).to eq 0
    end
  end

  describe 'GET #show' do
    it 'should return an order from session' do
      order = create :order
      session[:order_id] = order.id
      get :show
      expect(assigns(:order)).to eq order
    end
  end

  describe 'GET #pay' do
    it 'should render template' do
      order = create :order
      session[:order_id] = order.id
      get :pay
      expect(response).to render_template 'pay'
    end
  end

  describe 'POST #process_payment' do
    before do
      user  = create :user
      sign_in user
    end

    context 'with valid params' do
      before do
        @order = create(:order_item).order
        session[:order_id] = @order.id
        post :process_payment, conektaTokenId: 'tok_test_visa_4242'
      end

      it 'should return true status from Conekta' do
        expect(assigns(:cp).status).to be true
      end

      it 'should return paid message from Conekta' do
        expect(assigns(:cp).message).to eq 'Order paid! thank you!'
      end

      it 'should update order status' do
        expect(assigns(:order).paid?).to be true
      end

      it 'should update order token' do
        expect(assigns(:order).token).to_not be nil
      end

      it 'should delete session after pay' do
        expect(session[:order_id]).to be nil
      end
    end
  end
end
