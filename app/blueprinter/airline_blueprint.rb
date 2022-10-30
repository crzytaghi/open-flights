class AirlineBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :image_url, :slug
end