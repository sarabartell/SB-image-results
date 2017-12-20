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
    p "****"
    @images.each do |object|
      if !object.shapes["shapes"].empty?
        p object.shapes["shapes"][0]
      end
    end
  end
end

elephants = ElephantParser.parse('data.csv')

