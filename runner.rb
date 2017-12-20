require 'rmagick'
require 'csv'
require 'json'

class Elephant
  attr_reader :image_url
  attr_accessor :shapes

  def initialize(args={})
    @shapes = JSON.parse(args[:annotation])
    @image_url = args[:image_url]
  end

  def shapes=(value)
    @shapes = value
  end

end

module ElephantParser
  def self.parse(filename)
    @images = []

    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
        @images << Elephant.new(row)
    end

     object = @images[257]

        image_link = object.image_url
        # p "****"
        p "++++++++"
        p object.shapes["shapes"]
        p "++++++++"
        # p object.shapes["shapes"][0]["x"]
        # p object.shapes["shapes"][1]
        # p object.shapes["shapes"][2]
        # p object.shapes["shapes"][3]
         object.shapes["shapes"].each_with_index do |shape,i|
          p shape
          p i
          p "*****"
        end
        # image = Magick::Image.read(image_link).first
        # # p image
        # # p "***********"
        # bb = image.bounding_box
        # bb.x = object.shapes["shapes"][0]["x"]
        # bb.y = object.shapes["shapes"][0]["y"]
        # bb.width = object.shapes["shapes"][0]["width"]
        # bb.height = object.shapes["shapes"][0]["height"]

        # gc = Magick::Draw.new
        # gc.stroke_width(1)
        # gc.stroke('green')
        # gc.fill_opacity(0)

        # gc.rectangle(bb.x, bb.y, bb.x+bb.width, bb.y+bb.height)

        # gc.draw(image)

        # image.write('new2.gif')
        # exit
         # image = Magick::Image.read(image_link).first
        # bb = image.bounding_box
        # bb.x = object.shapes["shapes"][0]["x"]
        # bb.y = object.shapes["shapes"][0]["y"]
        # bb.width = object.shapes["shapes"][0]["width"]
        # bb.height = object.shapes["shapes"][0]["height"]

        # gc = Magick::Draw.new
        # gc.stroke('green')

        # gc.line(object.shapes["shapes"][0]["x"], object.shapes["shapes"][0]["y"], object.shapes["shapes"][1]["x"],
        #   object.shapes["shapes"][1]["y"])
        # gc.line(object.shapes["shapes"][1]["x"], object.shapes["shapes"][1]["y"], object.shapes["shapes"][2]["x"], object.shapes["shapes"][2]["y"])
        # gc.line(object.shapes["shapes"][2]["x"], object.shapes["shapes"][2]["y"], object.shapes["shapes"][3]["x"], object.shapes["shapes"][3]["y"])
        # gc.line(object.shapes["shapes"][3]["x"], object.shapes["shapes"][3]["y"], object.shapes["shapes"][0]["x"], object.shapes["shapes"][0]["y"])

        # gc.draw(image)
  end
end

elephants = ElephantParser.parse('data.csv')