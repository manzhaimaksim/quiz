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

def to_boolean(string)
  return true if string == 'true'
  return false if string == 'false'
  nil
end

doc.elements.each('questions/question') do |question|
  text = question.elements['text'].text

  variants = []
  question.elements.each('variants/variant') do |variant|
    variant.attributes['right'] ||= false
    variants << [variant.text, to_boolean(variant.attributes['right'])]
  end

  points = question.attributes['points'].to_i
  seconds = question.attributes['seconds'].to_i

  params = {text: text, variants: variants, points: points, seconds: seconds}
  questions << Question.new(params)
end

file.close

user_game = Game.new(questions)
user_interface = Interface.new(user_game)

