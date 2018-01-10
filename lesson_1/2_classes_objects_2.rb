class MyCar
  attr_accessor :color, :speed
  attr_reader :year

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def speed_up(n=5)
    @speed += n
  end

  def turn_off
    @speed = 0
  end

  def brake(n=5)
    @speed -= n
    turn_off if speed < 0
  end

  def spray_paint(c)
    self.color = c
  end

end

car = MyCar.new(2016, 'black', 'Tesla')
car.speed_up
p car.speed
car.speed_up(50)
p car.speed
car.brake
p car.speed
car.brake(15)
p car.speed
car.turn_off
p car.speed
p car.color
car.color = 'red'
p car.color
p car.year
car.spray_paint('blue')
p car.color
