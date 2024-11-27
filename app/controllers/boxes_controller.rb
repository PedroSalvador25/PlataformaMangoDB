class BoxesController < ApplicationController
  before_action :authenticate_user
  before_action :set_box, only: %i[ show edit update destroy ]

  # GET /boxes or /boxes.json
  def index
    @q = Box.ransack(params[:q]) 
    @boxes = @q.result(distinct: true) 
    @hectares_for_combo = Hectare.where.not(community: nil).map { |h| ["#{h.id} - #{h.community}", h.id] }
      logger.debug "Parámetros de búsqueda: #{params[:q].inspect}"
  end

  # GET /boxes/1 or /boxes/1.json
  def show
  end

  # GET /boxes/new
  def new
    @hectare = Hectare.find_by(id: params[:hectare_id])
    @box = Box.new(hectare: @hectare)
  end

  # GET /boxes/1/edit
  def edit
    @box = Box.find(params[:id])
    @hectare = @box.hectare
  end

  # POST /boxes or /boxes.json
  def create
    @box = Box.new(box_params)
    @hectare = Hectare.find(params[:box][:hectare_id]) 
  
    respond_to do |format|
      if @box.save
        format.html { redirect_to @hectare, notice: "La caja se creó correctamente." }
        format.json { render :show, status: :created, location: @hectare }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boxes/1 or /boxes/1.json
  def update
    respond_to do |format|
      if @box.update(box_params)
        format.html { redirect_to @box, notice: "Box was successfully updated." }
        format.json { render :show, status: :ok, location: @box }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boxes/1 or /boxes/1.json
  def destroy
    @box.destroy!

    respond_to do |format|
      format.html { redirect_to boxes_path, status: :see_other, notice: "Box was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_box
      @box = Box.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def box_params
      params.require(:box).permit(:quality, :weigth, :hectare_id) # Incluye :hectare_id
    end
end
