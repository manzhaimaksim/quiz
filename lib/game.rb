class Game
  # количество вопросов в игре
  NUMBER_OF_QUESTIONS = 5

  def initialize(questions)
    @questions = questions
    @points = 0
  end

  # игра
  def play_game
    @questions.sample(NUMBER_OF_QUESTIONS).each do |question|
      start = Time.now

      puts
      puts question
      variants = question.variants.shuffle

      variants.each.with_index(1) do |variant, index|
        puts "#{index}. #{variant[0]}"
      end

      user_input = 0

      puts
      until user_input.between?(1, 4)
        puts 'Введите номер варианта от 1 до 4'
        user_input = STDIN.gets.to_i
      end

      if variants[user_input - 1][1] == true
        puts 'Верный ответ'
        @points += question.points
      else
        puts "Неправильно. Правильный ответ #{question.true_answer}"
      end

      finish = Time.now

      if (finish - start) > question.seconds
        puts 'Слишком много времени'
        break
      end
    end

    show_result
  end

  # выводит результат на экран
  def show_result
    puts
    puts "Заработано баллов: #{@points}"
  end
end
