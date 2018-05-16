=begin
In the last question we had a module called Speed which contained a go_fast method.
We included this module in the Car class as shown below.

When we called the go_fast method from an instance of the Car class (as shown below)
you might have noticed that the string printed when we go fast includes the name
of the type of vehicle we are using. How is this done?

A: `self.class` will return the current object's class. Because it's interpolated,
we don't need to call `to_s`.
=end

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end
