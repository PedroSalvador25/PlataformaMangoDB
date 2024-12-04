class WarehousesController < ApplicationController
  before_action :authenticate_user
  before_action :set_warehouse, only: %i[show edit update destroy]

  # GET /warehouses or /warehouses.json
  def index
    @warehouses = Warehouse.all
  end

  # GET /warehouses/1 or /warehouses/1.json
  def show
    @warehouse = Warehouse.includes(shelves: :shelf_partitions).find(params[:id])
  end

  # GET /warehouses/new
  def new
    @warehouse = Warehouse.new
  end

  # GET /warehouses/1/edit
  def edit
  end

  # POST /warehouses or /warehouses.json
  def create
    @warehouse = Warehouse.new(warehouse_params)

    respond_to do |format|
      if @warehouse.save_record
        format.html { redirect_to @warehouse, notice: "Warehouse was successfully created." }
        format.json { render :show, status: :created, location: @warehouse }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @warehouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /warehouses/1 or /warehouses/1.json
  def update
    respond_to do |format|
      if @warehouse.update_record(warehouse_params)
        format.html { redirect_to @warehouse, notice: "Warehouse was successfully updated." }
        format.json { render :show, status: :ok, location: @warehouse }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @warehouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warehouses/1 or /warehouses/1.json
  def destroy
    if @warehouse.delete_record
      respond_to do |format|
        format.html { redirect_to warehouses_path, status: :see_other, notice: "Warehouse was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to warehouses_path, alert: "Error al eliminar el almacén." }
        format.json { render json: { error: "Error al eliminar el almacén." }, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :location, :warehouse_type)
  end
end

