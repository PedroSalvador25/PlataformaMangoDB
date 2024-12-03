class BoxesController < ApplicationController
  before_action :authenticate_user
  before_action :set_box, only: %i[ show edit update destroy ]

  # GET /boxes or /boxes.json
  def index
    @q = Box.ransack(params[:q])

    if current_user.role == 'WarehouseManager'
      @q.quality_eq = 'quality' unless params[:q] && params[:q][:quality_eq].present?
    end
    
    @boxes = @q.result.includes(:plant).order(created_at: :desc)
    @hectares_for_combo = Hectare.where.not(community: nil).map { |h| ["#{h.id} - #{h.community}", h.id] }
  end

  # GET /boxes/1 or /boxes/1.json
  def show
  end

  # GET /boxes/new
  def new
    @hectare = Hectare.find_by(id: params[:hectare_id])
    if @hectare
      @plants = @hectare.plants # Asocia las plantas de la hectárea
      @box = Box.new
    else
      redirect_to hectares_path, alert: "Hectárea no encontrada."
    end
  end

  # GET /boxes/1/edit
  def edit
    @box = Box.find(params[:id])
    @hectare = @box.hectare
  end

  # POST /boxes or /boxes.json
  def create
    @box = Box.new(box_params)

    if @box.save
      hectare_id = @box.plant.hectare.id
      redirect_to hectare_path(hectare_id), notice: 'Caja creada exitosamente.'
    else
      render :new
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

  def release_kilos
    box = Box.find(params[:id])
    kilos_to_release = params[:kilos]

    BoxesDatabaseService.call(box, kilos_to_release)

    render json: { message: 'Kilos liberados exitosamente' }, status: :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

#   def release_kilos
#     box = Box.find(params[:id])  
#     kilos_to_release = params[:kilos].to_f  

#     raise "No hay particiones con cajas disponibles" if box.shelf_partition.nil? || box.shelf_partition.box.nil?

#     remaining_kilos = kilos_to_release

#     while remaining_kilos > 0
#       current_partition = box.shelf_partition 
#       box_in_partition = current_partition.box

#       if box_in_partition.nil? || box_in_partition.kilos == 0
#         current_partition.update!(box: nil)  
#         warehouse.increment_output_pointer  
#         next
#       end

#       if box_in_partition.kilos >= remaining_kilos
#         box_in_partition.update!(kilos: box_in_partition.kilos - remaining_kilos)  # Restamos los kilos
#         break  
#       else
#         remaining_kilos -= box_in_partition.kilos
#         box_in_partition.update!(kilos: 0)  
#         current_partition.update!(box: nil)  
#         warehouse.increment_output_pointer   
#       end
#     end

#     render json: { message: "Kilos liberados correctamente" }
#   rescue => e
#     render json: { error: e.message }, status: :unprocessable_entity
#   end
# end
  private
    def set_box
      @box = Box.find(params[:id])
    end

    def box_params
      params.require(:box).permit(:quality, :weigth, :plant_id, :shelf_partition_id)
    end
end
