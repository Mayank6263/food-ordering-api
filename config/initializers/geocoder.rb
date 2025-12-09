# frozen_string_literal: true

require 'maxminddb'

# Path to your MMDB file
MMDB_PATH = Rails.root.join('lib', 'GeoLite2-City.mmdb').to_s

# Extend Geocoder module to add IP lookup
module Geocoder
  def self.lookup_ip(ip)
    @db ||= MaxMindDB.new(MMDB_PATH)
    record = @db.lookup(ip)
    return nil unless record.found?

    { ip: ip,
      city: record.city.name,
      state: record.subdivisions.first&.name,
      country: record.country.name,
      latitude: record.location.latitude,
      longitude: record.location.longitude }
  end
end

# Configure Geocoder gem for future use if needed
# (Optional, if you want to geocode full addresses too)
Geocoder.configure(
  timeout: 15,
  units: :km
)

# Defualt

# Geocoder.configure(
#   # Geocoding options
#   timeout: 15,                 # geocoding service timeout (secs)
#   lookup: :nominatim,         # name of geocoding service (symbol)
#   # ip_lookup: :ipinfo_io,      # name of IP address geocoding service (symbol)
#   # language: :en,              # ISO-639 language code
#   # use_https: false,           # use HTTPS for lookup requests? (if supported)
#   # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
#   # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
#   # api_key: nil,               # API key for geocoding service
#   # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)
#   http_headers: { "User-Agent" => "FoodOrderingApi" },

#   # Exceptions that should not be rescued by default
#   # (if you want to implement custom error handling);
#   # supports SocketError and Timeout::Error
#   # always_raise: [],

#   # Calculation options
#   units: :km,                 # :mi for kilometers or :mi for miles
#   # distances: :linear          # :spherical or :linear

#   # Cache configuration
#   # cache_options: {
#   #   expiration: 2.days,
#   #   prefix: 'geocoder:'
#   # }
# )
