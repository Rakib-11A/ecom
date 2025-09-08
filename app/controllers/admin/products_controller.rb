class Admin::ProductsController < AdminController
  before_action :set_admin_product, only: %i[ show edit update destroy remove_image ]
  # before_action :set_breadcrumbs
  # GET /admin/products or /admin/products.json
  def index
    add_breadcrumb "Home", admin_root_path
    add_breadcrumb "Products", admin_products_path
    @admin_products = Admin::Product.all
  end

  # GET /admin/products/1 or /admin/products/1.json
  def show
    add_breadcrumb "Home", admin_root_path
    add_breadcrumb "Products", admin_products_path
    add_breadcrumb @admin_product.name, admin_product_path(@admin_product)
  end

  # GET /admin/products/new
  def new
    add_breadcrumb "Home", admin_root_path
    add_breadcrumb "Products", admin_products_path
    add_breadcrumb "New Product"

    @admin_product = Admin::Product.new
  end

  # GET /admin/products/1/edit
  def edit
    add_breadcrumb "Home", admin_root_path
    add_breadcrumb "Products", admin_products_path
    add_breadcrumb @admin_product.name, admin_product_path(@admin_product)
    add_breadcrumb "Edit"
  end

  # POST /admin/products or /admin/products.json
  def create
    @admin_product = Admin::Product.new(admin_product_params)

    respond_to do |format|
      if @admin_product.save
        format.html { redirect_to @admin_product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @admin_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/products/1 or /admin/products/1.json
  def update
    if @admin_product.update(admin_product_params.reject { |k| k["images"] })
      if admin_product_params["images"]
        admin_product_params["images"].each do |image|
          @admin_product.images.attach(image)
        end
      end
      redirect_to admin_product_path(@admin_product), notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/products/1 or /admin/products/1.json
  def destroy
    @admin_product.destroy!

    respond_to do |format|
      format.html { redirect_to admin_products_path, notice: "Product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def remove_image
    image = @admin_product.images.find(params[:image_id])
    image.purge
    redirect_to edit_admin_product_path(@admin_product), notice: "Image was successfully removed"
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_product
      @admin_product = Admin::Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_product_params
      params.require(:admin_product).permit(:name, :description, :price, :category_id, :active, images: [])
      # params.expect(admin_product: [ :name, :description, :price, :category_id, :active, images: [] ])
    end
end
