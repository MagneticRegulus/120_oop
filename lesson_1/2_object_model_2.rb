module Greeting
  def greeting
    puts 'Hello!'
  end
end

class Student
  include Greeting
end

class Teacher
  include Greeting
end

becky = Student.new
becky.greeting
professor = Teacher.new
professor.greeting
puts ''
puts Student.ancestors
puts ''
puts Teacher.ancestors
puts ''

module College # also used for namespacing
  class Student
    include Greeting
  end

  class Teacher
    include Greeting
  end
end

becky = College::Student.new #namespacing?
becky.greeting
professor = College::Teacher.new #namespacing?
professor.greeting
puts ''
puts College::Student.ancestors
puts ''
puts College::Teacher.ancestors
