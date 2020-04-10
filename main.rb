require_relative 'lib/question'
require_relative 'lib/game'
require_relative 'lib/interface'
require 'rexml/document'

puts 'Мини-викторина. Ответьте на вопросы'

current_path = File.dirname(__FILE__)
file_path = current_path + '/' + 'data/questions.xml'

abort 'Не удалось найти файл с вопросами. Попробуйте в другой раз.' unless File.exist?(file_path)

file = File.new(file_path, "r:UTF-8")
doc = REXML::Document.new(file)

questions = []

doc.elements.each('questions/question') do |question|
  text = question.elements['text'].text

  variants = []
  question.elements.each('variants/variant') do |variant|
    variant.attributes['right'] ||= false
    variants << [variant.text, variant.attributes['right']]
  end

  points = question.attributes['points'].to_i
  seconds = question.attributes['seconds'].to_i

  params = { text: text, variants: variants, points: points, seconds: seconds }
  questions << Question.new(params)
end

file.close

user_game = Game.new(questions)
user_interface = Interface.new(user_game)

user_game.questions.each do |question|
  start = Time.now
  user_interface.show_question(question)
  user_interface.show_variants(question)
  user_input = user_interface.input
  user_interface.result(user_input, question)
  finish = Time.now
  break user_interface.time_is_done if (finish - start) > question.seconds
end

user_interface.total_result
