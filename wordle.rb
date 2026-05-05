LETTER_LENGTH = 5

def set_answer
  file_str = File.read("words.txt")
  arr = file_str.split("\n")
  arr[rand(arr.length)]
end

def check_answer_and_return_hint(answer, guess)
  hint_arr = (0...LETTER_LENGTH).map do |i|
    char = guess[i]
    if answer[i] == char
      "\e[42m#{char}\e[0m"
    elsif answer.include?(char)
      "\e[43m#{char}\e[0m"
    else
      "\e[90m#{char}\e[0m"
    end
  end

  hint_arr.join(" ")
end

def validate_entry(guess)
  error_messages = []
  unless guess.length == LETTER_LENGTH
    error_messages << "Not 5 letters"
  end

  unless guess.match?(/\A[a-zA-Z]+\z/)
    error_messages << "Letters only"
  end

  error_messages
end

answer = set_answer

6.times do |i|
  try_times = i + 1

  guess = ""

  loop do
    print "Guess #{try_times}/6: "
    guess = gets.chomp
    errors = validate_entry(guess)
    if errors.any?
      puts errors.join(", ")
    else
      break
    end
  end

  hint = check_answer_and_return_hint(answer, guess)

  puts hint

  if answer == guess
    puts "Correct! You got it in #{try_times} tries!"
    break
  elsif try_times == 6
    puts "Game over! The answer was #{answer}."
  else
    puts "Try one more time!"
  end
end
