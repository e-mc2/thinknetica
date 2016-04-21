puts "the quadratic equation: ax^2 + bx + c = 0"
print "a: "
a = Integer(gets.chomp)

print "b: "
b = Integer(gets.chomp)

print "c: "
c = Integer(gets.chomp)

d = b**2 - 4*a*c

if d < 0
  puts "the equation doesn't have the solution."
elsif d == 0
  puts "d = #{d}, x = #{-b/2*a}"
else
  puts "d = #{d}, x1 = #{(-b+Math.sqrt(d))/2*a}, x2 = #{(-b-Math.sqrt(d))/2*a}"
end
