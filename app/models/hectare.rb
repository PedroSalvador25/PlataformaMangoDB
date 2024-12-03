class Hectare < ApplicationRecord
  has_many :plants

  def self.ransackable_attributes(auth_object = nil)
    %w[community created_at id latitude longitude updated_at]
  end

  def self.search_hectares(query)
    HectaresDatabaseService.search_hectares(query)
  end

  def self.combo_options
    HectaresDatabaseService.combo_options
  end

  def self.update_ready_status(hectares)
    hectares.each do |hectare|
      is_ready = HarvestAuthorizationService.ready(hectare.id)
      HectaresDatabaseService.update_hectare(hectare, isReady: is_ready)
    end
  end

  def self.authorize_hectare(hectare_id)
    hectare = HectaresDatabaseService.find_hectare_by_id(hectare_id)

    return false if hectare.nil?

    if HarvestAuthorizationService.ready(hectare_id)
      HectaresDatabaseService.update_hectare(hectare, isAuthorized: true, isReady: true)
    else
      HectaresDatabaseService.update_hectare(hectare, isAuthorized: false, isReady: false)
    end
  end
end
