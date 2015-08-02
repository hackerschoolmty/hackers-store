require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe 'GET index' do
    it 'it should return list of products' do
      create_list :product, 10
      get :index
      expect(assigns(:products)).to have(10).items
    end

    it 'it should return specific product with search param' do
      create_list :product, 10
      create :product, name: 'my special product'
      get :index, q: 'my special product'
      expect(assigns(:products)).to have(1).items
    end
  end

  describe 'GET #new' do
    it 'should return a new empty product' do
      get :new
      expect(assigns(:product)).to be_a_new Product
    end

    it 'should render new template' do
      get :new
      expect(response).to render_template 'new'
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        product = attributes_for :product
        post :create, product: product
      end

      it 'should create a product' do
        expect(assigns(:product).id).to_not be nil
      end

      it 'should redirect to product after create' do
        expect(response).to redirect_to product_path(Product.last)
      end
    end

    context 'with invalid params' do
      before do
        product = attributes_for :product
        product[:name] = ''
        post :create, product: product
      end

      it 'should not create a product' do
        expect(assigns(:product).id).to be nil
      end

      it 'should render new template' do
        expect(response).to render_template 'new'
      end
    end
  end

  describe 'GET #show' do
    before do
      @product = create :product
      get :show, id: @product.id
    end

    it 'should return a product' do
      expect(assigns(:product)).to eq @product
    end
    
    it 'should render show template' do
      expect(response).to render_template 'show'
    end
  end

  describe 'GET #edit' do
    before do
      @product = create :product
      get :edit, id: @product.id
    end

    it 'should return a product' do
      expect(assigns(:product)).to eq @product
    end

    it 'should render edit template' do
      expect(response).to render_template 'edit'
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      before do
        product = create :product
        put :update, id: product.id, product: { name: 'product name' }
      end

      it 'should update product name' do
        expect(assigns(:product).name).to eq 'product name'
      end

      it 'should redirect to product after update' do
        expect(response).to redirect_to product_path(Product.last)
      end
    end

    context 'with invalid params' do
      before do
        product = create :product
        @product_name = product.name
        put :update, id: product.id, product: { name: '' }
      end

      it 'should update product name' do
        expect(assigns(:product).errors['name']).to include(
        t('errors.messages.blank'))
      end

      it 'should render edit template' do
        expect(response).to render_template 'edit'
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'should destroy a product' do
      product = create :product
      expect{
        delete :destroy, id: product.id
      }.to change{ Product.count }.by -1
    end
  end
end
