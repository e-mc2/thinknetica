print "first side of triangle: "
a = gets.chomp.to_f

print "second side of triangle: "
b = gets.chomp.to_f

print "third side of triangle: "
c = gets.chomp.to_f

array_of_sides = [a,b,c].sort

hypotenuse = array_of_sides[-1]
leg1 = array_of_sides[0]
leg2 = array_of_sides[1]

message = "It's a"

if hypotenuse**2 == leg1**2 + leg2**2
  message += " right"
end

if leg1 == leg2
  message += " isosceles"
end

if leg1 == leg2 && leg1 == hypotenuse
  message += " and equilateral"
end

puts message + " triangle."
