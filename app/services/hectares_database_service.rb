class HectaresDatabaseService
  def self.find_hectare_by_id(id)
    Hectare.find_by(id: id)
  end

  def self.find_plants_by_hectare_id(hectare_id)
    Plant.where(hectare_id: hectare_id)
  end

  def self.update_hectare(hectare, attributes)
    ActiveRecord::Base.transaction do
      hectare.update!(attributes)
    end
  end

  def self.search_hectares(query)
    query.result(distinct: true)
  end

  def self.combo_options
    Hectare.all.map { |h| ["#{h.id} - #{h.community}", h.id] }
  end
end