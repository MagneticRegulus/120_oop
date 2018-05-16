=begin
In the name of the cats_count method we have used self. What does self refer to
in this context?

A: This refers to the object class. This method can only be called on the class
`Cat` and not an instance of it.
=end

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

p Cat.cats_count # => 0
kitty = Cat.new('calico')
p Cat.cats_count # => 1
p kitty.cats_count # => NoMethodError
