class Restaurant < ApplicationRecord
  has_many :menu_items, dependent: :destroy
  validates :name, :address, presence: true, on: :create
  validate lambda {
   errors.add(:name, 'already exists') if !persisted? && Restaurant.exists?(name: name)
 }
 before_save :fetch_lat_long, on: %w[create, update]

  def fetch_lat_long
    locations = Geocoder.search(address)
    return if locations.empty?
    self.lat = locations[0].data["lat"]
    self.long = locations[0].data["lon"]
  end
end
