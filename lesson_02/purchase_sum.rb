shoplist = {}
total = 0
puts "What did you buy today?"

loop do
   
  numbers = {}

  puts "Purchase: "
  choise = gets.chomp.downcase
  break if choise == "stop"  

  print "amount: "
  amount = gets.chomp.to_i
  numbers["amount"] = amount

  print "prise: "
  prise = gets.chomp.to_f
  numbers["prise"] = prise

  shoplist[choise.capitalize!] = numbers
 
end
   
puts "---------------"
puts "Your shop list:"
    
shoplist.each do |item, numbers|
  numbers.each do |name, value|
    item += ", #{name} = #{value}"
  end
  total += numbers["amount"] * numbers["prise"]
  puts item
end

puts "Total sum: #{total}"
