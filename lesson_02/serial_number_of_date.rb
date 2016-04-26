puts "Year: "
year = gets.chomp.to_i

puts "Month: "
month = gets.chomp.to_i

puts "Day: "
day = gets.chomp.to_i

serial_number = 0;
common_days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
leap = year % 4 == 0 && year % 100 != 0 || year % 400 == 0

(month - 1).times do |i|
  serial_number += common_days_in_months[i]  
end

serial_number += day + (leap && month > 2 ? 1 : 0)

puts "Serial number of date is " + serial_number.to_s
