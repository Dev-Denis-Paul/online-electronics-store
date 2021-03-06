class OrderItemsController < ApplicationController
  before_action :set_order #, :get_products

  def create
    @order_item = @order.order_items.new(order_params)
    @order.save
    session[:order_id] = @order.id
    # @product = Product.find_by_id(params[:product_id])

    respond_to do |format|
      if @order_item
        format.html { redirect_to shops_url }
        format.json { render :show, status: :created, location: @order_item}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @order_item = @order.order_items.find(params[:id])
    @order_item.update(update_order_params)
    @order_items = current_cart.order_items

    respond_to do |format|
      if @order_item
        format.html { redirect_to cart_url }
        format.json { render :show, status: :ok, location: @order_item}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = current_cart.order_items
    
    respond_to do |format|
      if @order_item
        format.html { redirect_to cart_url }
        format.json { render :show, status: :created, location: @order_item}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def order_params
    params.permit(:id, :product_id, :quantity) # .require(:order_items)
  end

  def update_order_params
    params[:order_item].permit(:product_id, :quantity)
  end

  def set_order
    @order = current_cart
  end

  def get_products
    @products = Product.all
  end
end
