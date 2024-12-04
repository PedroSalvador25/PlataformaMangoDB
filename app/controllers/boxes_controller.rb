class BoxesController < ApplicationController
  before_action :authenticate_user
  before_action :set_box, only: %i[show edit update destroy release_kilos]

  # GET /boxes or /boxes.json
  def index
    @q = Box.search(params[:q], current_user)
    @boxes = @q.result.includes(:plant).order(created_at: :desc)
    @hectares_for_combo = Box.fetch_hectares_for_combo
  end

  # GET /boxes/1 or /boxes/1.json
  def show
  end

  # GET /boxes/new
  def new
    @hectare = Hectare.find_by(id: params[:hectare_id])
    if @hectare
      @plants = @hectare.plants
      @box = Box.new
    else
      redirect_to hectares_path, alert: "HectÃ¡rea no encontrada."
    end
  end

  # GET /boxes/1/edit
  def edit
    @box = Box.find(params[:id])
    @hectare = @box.plant&.hectare
    @plants = @hectare&.plants || []
  end

  # POST /boxes or /boxes.json
  def create
    result = Box.create_box(box_params)
    if result[:success]
      redirect_to hectare_path(result[:box].plant.hectare.id), notice: 'Caja creada exitosamente.'
    else
      @box = result[:box]
      render :new
    end
  end

  # PATCH/PUT /boxes/1 or /boxes/1.json
  def update
    result = Box.update_box(@box.id, box_params)
    if result[:success]
      redirect_to @box, notice: "Box was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /boxes/1 or /boxes.json
  def destroy
    if Box.destroy_box(@box.id)
      redirect_to boxes_path, status: :see_other, notice: "Box was successfully destroyed."
    else
      redirect_to boxes_path, status: :unprocessable_entity, alert: "Error al eliminar la caja."
    end
  end

  def release_kilos
    @box.release_kilos(params[:kilos])
    render json: { message: 'Kilos liberados exitosamente' }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def set_box
    @box = Box.find(params[:id])
  end

  def box_params
    params.require(:box).permit(:quality, :weigth, :plant_id, :shelf_partition_id)
  end
end


