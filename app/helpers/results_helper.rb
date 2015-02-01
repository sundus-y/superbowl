module ResultsHelper
  def get_percentage(num,total)
    ((num/total.to_f)*100).round(2)
  end
end
