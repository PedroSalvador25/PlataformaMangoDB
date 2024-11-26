module NavigationHelper
    def navigation_links
      links = []
      links << { name: "Almacen", path: warehouses_path, image: "icons/warehouse.svg"}
      links << { name: "Hectareas", path: hectares_path, image: "icons/hectare.svg" }
      links << { name: "Cajas", path: boxes_path, image: "icons/box.svg" }
      links << { name: "Plantas", path: plants_path, image: "icons/plant.svg" }
      links << { name: "Usuarios", path: users_path, image: "icons/user.svg" }
      links << { name: "Estantes", path: shelves_path, image: "icons/shelf.svg" }


      links
    end

  end