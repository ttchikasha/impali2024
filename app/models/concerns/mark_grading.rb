module MarkGrading
  class << self
    def get(mark)
      case mark
      when 85..100
        "A"
      when 77..84
        "B+"
      when 70..76
        "B"
      when 60..69
        "C++"
      when 50..59
        "C+"
      when 40..49
        "C"
      when 30..39
        "D"
      when 20..29
        "E"
      else
        "U"
      end
    end
  end
end
