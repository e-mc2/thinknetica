require 'date'

months_days = Hash.new

(1..12).each do |i|
  months_days[Date::MONTHNAMES[i]] = Date.civil(2016, i, -1).day	
end

months_days.each do |month, days| 
  if days == 30 
    puts month 
  end
end

