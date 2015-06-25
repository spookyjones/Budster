class PricesController < ApplicationController
  before_action :set_price, only: [:show, :edit, :update, :destroy]
  layout 'application'
  helper_method :sort_column, :sort_direction
  # GET /prices
  # GET /prices.json

  def index
    @strain_options = Strain.all.map{|s| [ s.name, s.id ] }
    @region_options = Region.all.map{|r| [ r.name, r.id ] }
    @price = Price.new
    @prices = Price.order(sort_column + " " + sort_direction).paginate(:per_page => 15, :page => params[:page])
    @strains = Strain.all
  end

  # GET /prices/1
  # GET /prices/1.json
  def show
  end

  # GET /prices/new
  def new
    @strain_params = params[:s_slug] || "unknown"
    @strain = Strain.find_or_create_by(name: @strain_params)
    @region_options = Region.all.map{|r| [ r.name, r.id ] }
    @price = Price.new
    @price.strain = @strain
  end

  # GET /prices/1/edit
  def edit
    @strain_options = Strain.all.map{|s| [ s.name, s.id ] }
    @region_options = Region.all.map{|r| [ r.name, r.id ] }
    @prices = Price.all
    @strains = Strain.all
    @regions = Region.all
  end

  # POST /prices
  # POST /prices.json
  def create
    @price = Price.new(price_params)
    @price.position = Price.count + 1
    respond_to do |format|
      if @price.save
        format.html { redirect_to "/", notice: 'Price was successfully created.' }
        format.json { render :show, status: :created, location: @price }
      else
        format.html { render :new }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prices/1
  # PATCH/PUT /prices/1.json
  def update
    @prices = Price.all
    @strains = Strain.all
    @regions = Region.all
    respond_to do |format|
      if @price.update(price_params)
        format.html { redirect_to "/", notice: 'Price was successfully updated.' }
        format.json { render :show, status: :ok, location: @price }
      else
        format.html { render :edit }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prices/1
  # DELETE /prices/1.json
  def destroy
    @price.destroy
    respond_to do |format|
      format.html { redirect_to prices_url, notice: 'Price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price
      @price = Price.find(params[:id])
      @prices = Price.order('position Asc')
      #@price.strain_id = Strain.find(params[:id]).id
      #@price.region_id = Region.find(params[:id]).id
    end
    
    def update_price
      
    end
    
    
  	def setup_navigation
          @prices = Price.order('position Asc')
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def price_params
      params.require(:price).permit(:cost, :position, :strain_id, :region_id, :strain, :region, strain_attributes: [:id, :name], region_attributes: [:id, :name])
    end
    
    def sort_column
      Price.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
end
