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

    @images.each do |object|
      if !object.shapes["shapes"].empty?
        image_link = object.image_url
        p "****"
        object.shapes["shapes"].each_with_index do |hash, i|

          image = Magick::Image.read(image_link).first
          bb = image.bounding_box
          bb.x = object.shapes["shapes"][i]["x"]
          bb.y = object.shapes["shapes"][i]["y"]
          bb.width = object.shapes["shapes"][i]["width"]
          bb.height = object.shapes["shapes"][i]["height"]

          gc = Magick::Draw.new
          gc.stroke('green')
          gc.fill_opacity(0)

          gc.rectangle(bb.x, bb.y, bb.x+bb.width, bb.y+bb.height)

          gc.draw(image)

          image.write('new-#{i}.gif')
          exit
        end
      end
    end
  end
end

elephants = ElephantParser.parse('data.csv')

