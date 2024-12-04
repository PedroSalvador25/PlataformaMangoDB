class ShelvesController < ApplicationController
  before_action :authenticate_user
  before_action :set_shelf, only: %i[show edit update destroy]

  # GET /shelves or /shelves.json
  def index
    @shelves = Shelf.all
  end

  # GET /shelves/1 or /shelves/1.json
  def show
  end

  # GET /shelves/new
  def new
    @shelf = Shelf.new
  end

  # GET /shelves/1/edit
  def edit
  end

  # POST /shelves or /shelves.json
  def create
    @shelf = Shelf.new(shelf_params)

    respond_to do |format|
      if @shelf.save_record
        format.html { redirect_to @shelf, notice: "Shelf was successfully created." }
        format.json { render :show, status: :created, location: @shelf }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shelf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shelves/1 or /shelves/1.json
  def update
    respond_to do |format|
      if @shelf.update_record(shelf_params)
        format.html { redirect_to @shelf, notice: "Shelf was successfully updated." }
        format.json { render :show, status: :ok, location: @shelf }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shelf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shelves/1 or /shelves/1.json
  def destroy
    if @shelf.delete_record
      respond_to do |format|
        format.html { redirect_to shelves_path, status: :see_other, notice: "Shelf was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to shelves_path, alert: "Error al eliminar la estantería." }
        format.json { render json: { error: "Error al eliminar la estantería." }, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_shelf
    @shelf = Shelf.find(params[:id])
  end

  def shelf_params
    params.require(:shelf).permit(:warehouse_id)
  end
end


  
