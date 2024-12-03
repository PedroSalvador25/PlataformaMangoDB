module NavigationHelper
  def navigation_links
    links = []
    if user_has_role?(current_user, :Administrator)
      links << { name: "Hectareas", path: hectares_path, image: "icons/hectare.svg" }
      
    end 
    if user_has_role?(current_user, :WarehouseManager)
      links << { name: "Cajas", path: boxes_path, image: "icons/box.svg" }
      links << { name: "Almacen", path: warehouses_path, image: "icons/warehouse.svg" }
      
    end
    if user_has_role?(current_user, :Tagger)
      links << { name: "Cajas", path: boxes_path, image: "icons/box.svg" }
      links << { name: "Etiquetar", path: hectares_path, image: "icons/hectare.svg" }
    end
    links << { name: "Usuarios", path: users_path, image: "icons/user.svg" }

    links
  end
end

