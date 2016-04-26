shoplist = {}
total = 0
puts "What did you buy today?"

loop do

  puts "Purchase: "
  choise = gets.chomp.downcase

  case choise
  when "stop"
    
    puts "---------------"
    puts "Your shop list:"
    
    shoplist.each do |item, numbers|
      numbers.each do |name, value|
        item += ", "+name+" = "+value.to_s
        total += value
      end
      puts item
    end

    puts "Total sum: "+total.to_s
    break

  else
    
    numbers = {}
    
    print "amount: "
    amount = gets.chomp.to_i
    numbers["amount"] = amount

    print "prise: "
    prise = gets.chomp.to_f
    numbers["prise"] = prise

    shoplist[choise.capitalize!] = numbers
    
  end

end
