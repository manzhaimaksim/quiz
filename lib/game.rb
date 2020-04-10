class Game
  # количество вопросов в игре
  NUMBER_OF_QUESTIONS = 5

  attr_accessor :points

  def initialize(questions)
    @user_interface = Interface.new(self)
    @questions = questions
    @points = 0
  end

  # игра
  def play_game
    @questions.sample(NUMBER_OF_QUESTIONS).each do |question|
      start = Time.now

      @user_interface.show_question(question)

      variants = question.variants.shuffle
      @user_interface.show_variants(variants)

      user_input = @user_interface.input
      @user_interface.result(user_input, question, variants)

      finish = Time.now

      if (finish - start) > question.seconds
        @user_interface.time_is_done
        break
      end
    end

    @user_interface.show_result
  end
end
