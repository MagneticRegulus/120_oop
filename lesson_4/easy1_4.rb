=begin
If we have a class AngryCat how do we create a new instance of this class?

A: we use the `new` method on the class which will initialize a new object.
=end

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

kitty = AngryCat.new
kitty.hiss
