class Interface
  def initialize(game)
    @game = game
  end

  def show_question(question)
    puts "#{question.text} (Баллы: #{question.points})"
  end

  def show_variants(question)
    question.variants.each.with_index(1) do |variant, index|
      puts "#{index}. #{variant[0]}"
    end
  end

  def input
    user_input = 0

    until user_input.between?(1, 4)
      puts 'Введите номер варианта от 1 до 4'
      user_input = STDIN.gets.to_i
    end
    user_input
  end

  def result(answer, question)
    if question.variants[answer - 1][1] == 'true'
      puts 'Верный ответ'
      @game.points += question.points
    else
      puts "Неправильно. Правильный ответ #{question.true_answer}"
    end
  end

  def time_is_done
    puts 'Слишком много времени'
  end

  # выводит результат на экран
  def total_result
    puts
    puts "Заработано баллов: #{@game.points}"
  end
end
