=begin
Which of these two classes has an instance variable and how do you know?

A: Pizza. Instance variables always have a single `@` as a preffix. The `name`
variable in the `Fruit#initialize` method is a local variable, only available to
the method.
=end

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

p Pizza.new('pepperoni') # => #<Pizza:0x000000022f4250 @name="pepperoni">
p Fruit.new('apple') # => #<Fruit:0x000000022f4098> - no name variable

# can also use the `#instance_variables` method to check for ivars
dinner = Pizza.new('cheese')
snack = Fruit.new('grapes')
p dinner.instance_variables # => [:@name]
p snack.instance_variables # => []
