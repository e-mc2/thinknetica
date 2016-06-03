class Route
  attr_accessor :points

  def initialize(start_point, end_point)
    @points = []
    @points << start_point 
    @points << end_point
  end

  def add_point(point)
    self.points.insert(-2, point)
  end

  def delete_point(point)
    self.points.delete(point)
  end

  def show
    points.each {|item| puts " |-- " + item.name} 
  end

end
