class HectaresController < ApplicationController
  before_action :authenticate_user
  before_action :set_hectare, only: %i[show edit update destroy authorize]

  # GET /hectares or /hectares.json
  def index
    @q = Hectare.ransack(params[:q])
    @hectares = Hectare.search_hectares(@q)
    @hectares_for_combo = Hectare.combo_options
    Hectare.update_ready_status(@hectares)
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

    if @hectare.save_record
      redirect_to @hectare, notice: "Hectárea fue creada exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hectares/1 or /hectares/1.json
  def update
    if @hectare.update_record(hectare_params)
      redirect_to @hectare, notice: "Hectárea fue actualizada exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /hectares/1 or /hectares.json
  def destroy
    if @hectare.delete_record
      redirect_to hectares_path, status: :see_other, notice: "Hectárea fue eliminada exitosamente."
    else
      redirect_to hectares_path, alert: "Error al eliminar la hectárea."
    end
  end

  # PATCH /hectares/:id/authorize
  def authorize
    if Hectare.authorize_hectare(params[:id])
      redirect_to hectare_path(params[:id]), notice: "Hectárea autorizada exitosamente."
    else
      redirect_to hectare_path(params[:id]), alert: "Error al autorizar la hectárea."
    end
  end

  private

  def set_hectare
    @hectare = Hectare.find(params[:id])
  end

  def hectare_params
    params.require(:hectare).permit(:latitude, :longitude, :community)
  end
end
