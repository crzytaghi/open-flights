class AirlineSerializer
  include JSONAPI::Serializer
  # attributes determines what is being returned, typically in the form of json so it can be read by the front-end
  attributes :name, :image_url, :slug

  has_many :reviews
end
