require 'rmagick'
require 'csv'
require 'json'
require_relative 'elephant'

module BoxElephants
  def self.edit_images(filename)
    @images = []

    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
        @images << Elephant.new(row)
    end

    @images.each do |object|
      if !object.shapes["shapes"].empty?
        image_link = object.image_url
        split = image_link.split("exercise/")[1]

        object.shapes["shapes"].each_with_index do |hash, i|

          @image = Magick::Image.read(image_link).first
          bb = @image.bounding_box
          bb.x = object.shapes["shapes"][i]["x"]
          bb.y = object.shapes["shapes"][i]["y"]
          bb.width = object.shapes["shapes"][i]["width"]
          bb.height = object.shapes["shapes"][i]["height"]

          gc = Magick::Draw.new
          gc.stroke('green')
          gc.fill_opacity(0)
          gc.stroke_width(2.5)

          gc.rectangle(bb.x, bb.y, bb.x+bb.width, bb.y+bb.height)

          gc.draw(@image)

          @image.write("new_photos/thumb-#{split}")

          image_link = "new_photos/thumb-#{split}"
        end
      end
    end
  end
end

elephants = BoxElephants.edit_images('data.csv')

