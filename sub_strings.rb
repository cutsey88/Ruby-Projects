def sub_string(string, dictionary)
  
  down_dictionary = dictionary.map {|word| word.downcase}

  down_dictionary.reduce(Hash.new(0)) do |result, word|
    for i in 0..string.length - 1
      strindex = i
      match_counter = 0
      if word[0] == string[i]
        for j in 0..word.length - 1
          if word[j] == string[strindex]
            match_counter += 1
            strindex += 1
            if match_counter == word.length - 1
              result[word] += 1
            end
          end
        end
      end
    end
    result
  end
end

puts "Whats your string?"
in_string = gets.chomp.downcase

puts "What's your dictionary?"
in_dictionary = gets.chomp.split(" ")

puts sub_string(in_string, in_dictionary)
