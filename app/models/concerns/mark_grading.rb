module MarkGrading
  class << self
    def get(mark)
      case mark
      when 85..100
        1
      when 77..84
        2
      when 70..76
        3
      when 60..69
        4
      when 50..59
        5
      when 40..49
        6
      when 30..39
        7
      when 20..29
        8
      else
        9
      end
    end
  end
end
