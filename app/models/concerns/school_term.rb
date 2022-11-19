module SchoolTerm
  def self.get(date = Date.today)
    month = date.month
    case month
    when 1..4
      "Term 1"
    when 5..8
      "Term 2"
    else
      "Term 3"
    end
  end
end
