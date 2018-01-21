class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Bulldog < Dog
  def swim
    'can\'t swim!'
  end
end

#Method lookup path:

puts Bulldog.ancestors

=begin
Bulldog
Dog
Pet
Object
Kernel
BasicObject
=end

# It's important to know and understand in what order ruby will look for methods
# It's easy to overwrite superclass methods
