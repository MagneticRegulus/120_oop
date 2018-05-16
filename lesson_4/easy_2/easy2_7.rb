=begin
Explain what the @@cats_count variable does and how it works. What code would you
need to write to test your theory?
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

# `@@cats_count` keeps track of how many Cat objects have been initialized
# throughout the program.

p Cat.cats_count # => 0
kitty = Cat.new('calico')
p Cat.cats_count # => 1
fluffly = Cat.new('persian')
p Cat.cats_count # => 2
