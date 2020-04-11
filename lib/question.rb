class Question
  attr_reader :text, :variants, :points, :seconds

  def initialize(params)
    @text = params[:text]
    @variants = params[:variants].shuffle
    @points = params[:points]
    @seconds = params[:seconds]
  end

  # возвращает правильный ответ
  def true_answer
    @variants.find { |variant| variant[1] == 'true' }[0]
  end
end
