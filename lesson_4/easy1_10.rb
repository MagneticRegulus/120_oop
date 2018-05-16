=begin
If we have the class below, what would you need to call to create a new instance
of this class.

A: the `new` method with arguments.
=end

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

bookbag = Bag.new('R2D2', 'canvas')
