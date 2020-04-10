class Game
  # количество вопросов в игре
  NUMBER_OF_QUESTIONS = 5

  attr_accessor :points, :questions

  def initialize(questions)
    @questions = questions.sample(NUMBER_OF_QUESTIONS).shuffle
    @points = 0
  end
end
