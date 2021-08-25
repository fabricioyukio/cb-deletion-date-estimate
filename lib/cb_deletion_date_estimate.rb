require 'date'

class CbDeletionDateEstimate
  def self.is_due?(retention_plan, created_at)
    due_date = created_at + 42
    
    if ['GOLD','PLATINUM']include? retention_plan
      due_date = due_date + x


  end

  def last_of_the_month(dt)
    dt_ = dt +1
    return dt.month == dt_.month
  end

  def last_of_the_year(dt)
    dt_ = dt + ()
    return dt.year == dt_.year
  end
end