class NatoAlphabet
  WORDS = ["Alfa", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "India", "Juliet", "Kilo", "Lima", "Mike", "November", "Oscar", "Papa", "Quebec", "Romeo", "Sierra", "Tango", "Uniform", "Victor", "Whiskey", "X-Ray", "Yankee", "Zulu"]
  LENGTH = WORDS.length
end

class NatoAlphabetTester

  OPTS = ["all", "random"]

  DOCS = <<-docs
Usage: ruby nato-alphabet <action>

`action`, here, takes one of two possible values:
1. all (default):
    the script will cycle from a-z, and ask you to enter the word for each
    letter.
2. random:
    randomly picks a letter and tests you.
docs

  class Score
    attr_accessor :correct, :incorrect

    def initialize(c, i)
      @correct, @incorrect = c, i
    end
  end

  def compare(answer, correct)
    if answer == correct
      puts "Correct.\n"
      @score.correct += 1
    else
      puts "Incorrect. The correct answer is '#{correct}'."
      @score.incorrect += 1
    end
  end

  def ask(word)
    q = "\nEnter the telephony for the letter #{word[0]}: "
    print q
    STDIN.gets.strip.capitalize
  end

  def test_all()
    NatoAlphabet::WORDS.each do |word|
      compare(ask(word), word)
    end
    print_score
  end

  def test_random()
    while true
      word = NatoAlphabet::WORDS[rand(NatoAlphabet::LENGTH)]
      compare(ask(word), word)
    end
  end

  def print_score
    puts "\n\n"
    puts "-"*35
    puts "Thank you for trying nato-alphabet!\n\n"
    puts "Your score:"
    puts "  Correct: #{@score.correct}"
    puts "  Incorrect: #{@score.incorrect}"
    puts "  Total: #{@score.correct + @score.incorrect}"
    puts "-"*35
  end

  def initialize(mode)
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

NatoAlphabetTester.new(ARGV[0])