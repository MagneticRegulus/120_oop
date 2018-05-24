class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end

  def self.hi # added method
    puts self.to_s # or just puts "Hello"
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# If we call Hello.hi we get an error message. How would you fix this?

Hello.hi
Hello.new.hi

=begin
LS solution
class Hello
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end
=end
