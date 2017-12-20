require 'json'

class Elephant
  attr_reader :image_url
  attr_accessor :shapes

  def initialize(args={})
    @shapes = JSON.parse(args[:annotation])
    @image_url = args[:image_url]
  end

end