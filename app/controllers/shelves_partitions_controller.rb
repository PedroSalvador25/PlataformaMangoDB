class ShelvesPartitionsController < ApplicationController

    def assign_box
        partition = ShelfPartition.find(params[:id])
        box = Box.find(params[:box_id])
        partition.assign_box(box)
        redirect_to partition_path(partition), notice: "Caja asignada exitosamente."
      rescue StandardError => e
        redirect_to partition_path(partition), alert: e.message
      end
    
      def release_box
        partition = ShelfPartition.find(params[:id])
        box = partition.release_box
        redirect_to partition_path(partition), notice: "Caja liberada exitosamente. Caja: #{box.id}"
      rescue StandardError => e
        redirect_to partition_path(partition), alert: e.message
      end
end
