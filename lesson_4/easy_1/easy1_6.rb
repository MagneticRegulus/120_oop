=begin
What could we add to the class below to access the instance variable @volume?

A: a getter method, defined using `attr_reader`. Can also kill 2 birds with one stone
and use `attr_accessor` to also define a setter method.
=end

class Cube
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end
end

rubix = Cube.new(20)
rubix.volume # => 20

# could also use the `instance_variable_get` method
 p rubix.instance_variable_get('@volume')
