#
class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.paginate(page: params[:page], per_page: 20)
    @products = @products.where(
      'name LIKE ? OR description LIKE ?',
      "%#{params[:q]}%", "%#{params[:q]}%") if params[:q].present?
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
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
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
    params.require(:product).permit(:name, :description,
                                    :price, :stock, :author_id)
  end
end
