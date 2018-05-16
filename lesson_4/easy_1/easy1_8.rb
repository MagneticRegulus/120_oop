=begin
You can see in the make_one_year_older method we have used self. What does self
refer to here?

A: the object the method is being called on. I'm not sure why this would be used over
`@age += 1` though.
=end

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

kitty = Cat.new('calico')
kitty.make_one_year_older
kitty.make_one_year_older
p kitty.age
