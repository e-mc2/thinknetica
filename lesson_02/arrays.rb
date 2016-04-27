array_with_step = (10..100).step(5).to_a

array_fibonacci = [0,1]
loop do  
  array_fibonacci << array_fibonacci[-1] + array_fibonacci[-2] 
  break if array_fibonacci[-1] + array_fibonacci[-2] > 100
end
