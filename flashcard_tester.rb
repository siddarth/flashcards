#!/usr/bin/env ruby

class FlashcardTester

  OPTS = ["all", "random"]

  DOCS = "
Usage: #{$0} <action>

`action`, here, takes one of two possible values:
1. all (default):
    the script will cycle through the questions, and ask you to enter the
    answer for each one.
2. random:
    randomly picks a question and tests you.
"

  class Score
    attr_accessor :correct, :incorrect, :question_format

    def initialize(c, i)
      @correct, @incorrect = c, i
    end
  end

  def compare(answer, correct)
    if answer.strip.capitalize == correct.strip.capitalize
      puts "Correct.\n"
      @score.correct += 1
    else
      puts "Incorrect. The correct answer is '#{correct}'."
      @score.incorrect += 1
    end
  end

  def ask(key)
    q = sprintf("#{@question_format}", key)
    print "\n" + q
    STDIN.gets
  end

  def test_all()
    @answer_key.keys.each do |key|
      answer = ask(key)
      correct = @answer_key[key]
      compare(answer, correct)
    end
    print_score
  end

  def test_random()
    keys = @answer_key.keys
    size = @answer_key.size
    while true
      key = keys[rand(size)]
      answer = @answer_key[key]
      compare(ask(key), answer)
    end
  end

  def print_score
    puts "\n\n"
    str = "Thank you for taking the #{@test_name} test!\n\n"
    puts "-"*str.length
    puts str
    puts "Your score:"
    puts "  Correct: #{@score.correct}"
    puts "  Incorrect: #{@score.incorrect}"
    puts "  Total: #{@score.correct + @score.incorrect}"
    puts "-"*str.length
  end

  def initialize(test_name, mode, question_format, answer_key)
    @test_name, @answer_key = test_name, answer_key
    @question_format = question_format
    @score = Score.new(0, 0)
    mode ||= "all"
    run(mode)
  end

  def run(mode)
    begin
      case mode
        when 'all'
          test_all()
        when 'random'
          test_random()
        else
          puts DOCS
      end
    rescue Interrupt
      print_score
      exit(0)
    end
  end
end