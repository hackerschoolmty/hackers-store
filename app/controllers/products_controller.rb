class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.paginate(page: params[:page], per_page: 20)

    if params[:q].present?
      @products = @products.where(['name LIKE ? OR description LIKE ?', "%#{params[:q]}%", "%#{params[:q]}%"])
    end
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product
      @product = if params[:id].to_i.to_s == params[:id]
        @product.find(params[:id])
      else
        @product.find_by(slug: params[:id])
      end
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :stock, :author_id, :product_photo)
    end
end
