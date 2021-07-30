def caesar_cipher(string, shift_num)
  output_string = ""
  uppercase_letters = ("A".."Z").to_a
  lowercase_letters = ("a".."z").to_a

  def shift_character(character, shift_by)
    ordinal = character.ord
    shift_by.times do
      if ordinal == 90
        ordinal = 65
      elsif ordinal == 122
        ordinal = 97
      else
        ordinal += 1
      end
    end
    ordinal.chr
  end
  string.each_char do |char|
    if uppercase_letters.include?(char) || lowercase_letters.include?(char)
      output_string.concat(shift_character(char, shift_num))
    else
      output_string.concat(char)
    end
  end
  p output_string
end
puts "Gimme a string"
in_string = gets.chomp

puts "Gimme a shift number"
in_shift = gets.chomp.to_i

caesar_cipher(in_string, in_shift)