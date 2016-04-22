print "Hi! What is your name? "
name = gets.chomp
name.capitalize!

print "#{name}, How tall are you? "
growth = gets.chomp.to_i

ideal_weight = growth - 110

if ideal_weight < 0 
  print "#{name}, your weight is already ideal :)"
else
  print "#{name}, your ideal weight is #{ideal_weight} kg."
end
