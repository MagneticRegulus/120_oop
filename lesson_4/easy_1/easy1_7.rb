=begin
What is the default return value of to_s when invoked on an object? Where could
you go to find out if you want to be sure?

A: The default return value of an object is a long string with the object's
class and an encoding of the object id. This looks weird. This is defined at the
`Object` class level and the docs for this are located
here: https://ruby-doc.org/core-2.3.1/Object.html#method-i-to_s

You can call `to_s` on an object to see it's default return value.
=end

class Cube
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end
end

rubix = Cube.new(20)
p rubix.to_s # => "#<Cube:0x000000024bc498>"
