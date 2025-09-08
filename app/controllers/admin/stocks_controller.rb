class Admin::StocksController < AdminController
  before_action :set_admin_product
  before_action :set_stock, only: %i[ show edit update destroy ]

  def index
    @stocks = @admin_product.stocks.by_size
  end

  def show; end

  def new
    @stock = @admin_product.stocks.build
  end

  def create
    @stock = @admin_product.stocks.build(stock_params)
    if @stock.save
      redirect_to admin_product_stocks_path(@admin_product), notice: "Stock was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @stock.update(stock_params)
      redirect_to admin_product_stocks_path(@admin_product), notice: "Stock was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @stock.destory
    redirect_to admin_product_stocks_path(@admin_product), notice: "Stock was successfully destroyed."
  end


  private

  def set_admin_product
    @admin_product = Admin::Product.find(params[:product_id])
  end

  def set_stock
    @stock = @admin_product.stocks.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:size, :amount)
  end
end
