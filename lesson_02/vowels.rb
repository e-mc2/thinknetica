vowels = "aeoui"
alphabet = ("a".."z").to_a
hash_vowels = {}

alphabet.each_with_index do |item, index|
  hash_vowels[item] = index+1 if vowels.include? item 
end

puts hash_vowels
