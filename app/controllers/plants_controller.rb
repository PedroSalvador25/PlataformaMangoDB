class PlantsController < ApplicationController
  before_action :authenticate_user
  before_action :set_plant, only: %i[show edit update destroy]

  # GET /plants or /plants.json
  def index
    @plants = Plant.all
  end

  # GET /plants/1 or /plants/1.json
  def show
  end

  # GET /plants/new
  def new
    @plant = Plant.new
  end

  # GET /plants/1/edit
  def edit
  end

  # POST /plants or /plants.json
  def create
    @plant = Plant.new(plant_params)

    respond_to do |format|
      if @plant.save_record
        format.html { redirect_to @plant, notice: "Plant was successfully created." }
        format.json { render :show, status: :created, location: @plant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @plant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plants/1 or /plants/1.json
  def update
    respond_to do |format|
      if @plant.update_record(plant_params)
        format.html { redirect_to @plant, notice: "Plant was successfully updated." }
        format.json { render :show, status: :ok, location: @plant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @plant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plants/1 or /plants/1.json
  def destroy
    if @plant.delete_record
      respond_to do |format|
        format.html { redirect_to plants_path, status: :see_other, notice: "Plant was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to plants_path, alert: "Error al eliminar la planta." }
        format.json { render json: { error: "Error al eliminar la planta." }, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_plant
    @plant = Plant.find(params[:id])
  end

  def plant_params
    params.require(:plant).permit(:humidity, :growthMm, :heatJoules, :steamThicknessMm, :pestPresence, :texture, :oxygenationLevel, :hectare_id)
  end
end

