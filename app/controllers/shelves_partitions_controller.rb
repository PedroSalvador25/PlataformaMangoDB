class ShelvesPartitionsController < ApplicationController
  def assign_box
    partition = ShelfPartition.find(params[:id])
    box = Box.find(params[:box_id])

    begin
      partition.assign_box(box)
      redirect_to boxes_path, notice: "Caja asignada exitosamente al almacén."
    rescue StandardError => e
      redirect_to boxes_path, alert: e.message
    end
  end

  def release_box
    partition = ShelfPartition.find(params[:id])
    box = partition.release_box
    redirect_to boxes_path, notice: "Caja liberada exitosamente. Caja: #{box.id}"
  rescue StandardError => e
    redirect_to boxes_path, alert: e.message
  end
end



