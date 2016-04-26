vowels = "aeoui"
alphabet = ("a".."z").to_a
hash_vowels = {}

alphabet.each_with_index do |item, index|
  if vowels.include? item 
    hash_vowels[item] = index+1
  end 
end

puts hash_vowels
