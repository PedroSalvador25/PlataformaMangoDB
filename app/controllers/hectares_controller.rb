class HectaresController < ApplicationController
  before_action :authenticate_user
  before_action :set_hectare, only: %i[ show edit update destroy ]



  # GET /hectares or /hectares.json
  def index
    @hectares_for_combo = Hectare.all.map { |h| [ "#{h.id} - #{h.community}", h.id ] }
    @q = Hectare.ransack(params[:q])
    @hectares = @q.result(distinct: true)
    
    @hectares.each do |hectare|
      hectare.check_hectare(hectare.id)
    end
  end

  # GET /hectares/1 or /hectares/1.json
  def show
  end

  # GET /hectares/new
  def new
    @hectare = Hectare.new
  end

  # GET /hectares/1/edit
  def edit
  end

  # POST /hectares or /hectares.json
  def create
    @hectare = Hectare.new(hectare_params)

    respond_to do |format|
      if @hectare.save
        format.html { redirect_to @hectare, notice: "Hectare was successfully created." }
        format.json { render :show, status: :created, location: @hectare }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hectare.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hectares/1 or /hectares/1.json
  def update
    respond_to do |format|
      if @hectare.update(hectare_params)
        format.html { redirect_to @hectare, notice: "Hectare was successfully updated." }
        format.json { render :show, status: :ok, location: @hectare }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hectare.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hectares/1 or /hectares/1.json
  def destroy
    @hectare.destroy!

    respond_to do |format|
      format.html { redirect_to hectares_path, status: :see_other, notice: "Hectare was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def authorize
    @hectare = Hectare.find_by(id: params[:id])
    
    if @hectare.authorize!
      redirect_to @hectare, notice: "Hectárea autorizada exitosamente."
    else
      redirect_to @hectare, alert: "Error al autorizar la hectárea."
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hectare
      @hectare = Hectare.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hectare_params
      params.require(:hectare).permit(:latitude, :longitude, :community)
    end
end
