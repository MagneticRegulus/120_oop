class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
p bob.name
bob.name = "Bob"
p bob.name

# got the error because there is no implicit or explicit method to change
# the state of the name attribute. This can be resolved by changing `attr_reader`
# to `attr_accessor`
