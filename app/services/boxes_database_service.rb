class BoxesDatabaseService
    def initialize(box, kilos_to_release)
      @box = box
      @kilos_to_release = kilos_to_release.to_f
      @remaining_kilos = @kilos_to_release
      @warehouse = @box.warehouse  
    end
  
    def self.call(box, kilos_to_release)
        
      raise "No hay particiones con cajas disponibles" if @box.shelf_partition.nil? || @box.shelf_partition.box.nil?
  
      while @remaining_kilos > 0
        current_partition = @box.shelf_partition 
        box_in_partition = current_partition.box
  
        if box_in_partition.nil? || box_in_partition.kilos == 0
          current_partition.update!(box: nil)  
          @warehouse.increment_output_pointer  
          next
        end
  
        if box_in_partition.kilos >= @remaining_kilos
          box_in_partition.update!(kilos: box_in_partition.kilos - @remaining_kilos)  # Restamos los kilos
          break  
        else
          @remaining_kilos -= box_in_partition.kilos
          box_in_partition.update!(kilos: 0)  
          current_partition.update!(box: nil)  
          @warehouse.increment_output_pointer   
        end
      end
    end
  end
  