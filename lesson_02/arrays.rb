array_with_step = (10..100).step(5).to_a

array_fibonacci = [0,1]
100.times.each_with_object(array_fibonacci) do |num, obj| 
  new_item = obj[-2] + obj[-1]
  break if new_item > 100
  obj << new_item
end
