class Question
  attr_reader :text, :variants, :points, :seconds

  def initialize(params)
    @text = params[:text]
    @variants = params[:variants]
    @points = params[:points]
    @seconds = params[:seconds]
  end

  def to_s
    "#{@text} (Баллы: #{@points})"
  end

  # выводит правильный ответ
  def true_answer
    @variants.each { |variant| return variant[0] if variant[1] == 'true' }
  end
end
