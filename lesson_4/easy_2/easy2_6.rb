# Which one of these is a class method (if any) and how do you know? How would
# you call a class method?

class Television
  def self.manufacturer # class method. Prepended with `self`
    # method logic
  end

  def model
    # method logic
  end
end

# Called on the class itself rather than a variable:

Television.manufacturer
