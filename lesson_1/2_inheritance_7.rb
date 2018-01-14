class Student
  attr_reader :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(student)
    grade > student.grade
  end

  protected # initially wrote private

  def grade
    @grade
  end
end

joe = Student.new('Joe', 94)
bob = Student.new('Bob', 85)
puts "Well done!" if joe.better_grade_than?(bob)
