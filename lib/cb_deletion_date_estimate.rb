require 'date'

class CbDeletionDateEstimate
  def self.is_due?(retention_plan, created_at)
    retention_plan = retention_plan.upcase
    raise ArgumentError unless (
                                retention_plan.is_a?(String) &&
                                ['STANDARD','GOLD','PLATINUM'].include?(retention_plan)
                              )
    raise ArgumentError unless (
                                created_at.is_a?(Date) &&
                                created_at <= Date.today
                              )

    # anyways, it should keep a snapshot at least for 42 days
    due_date = created_at + 42
    
    if ['GOLD','PLATINUM'].include?(retention_plan) then
      puts "GOLD OR PLATINUM"
      due_date = due_date.next_year if self.last_of_the_month(created_at)
    end

    if ['PLATINUM'].include?(retention_plan) then
      if self.last_of_the_year(created_at) then
        # it advances 6 years, instead of 7 because it already advanced 1 above
        6.times do
          due_date = due_date.next_year
        end
      end
    end

    today = Date.today
    puts "today: #{today}"
    puts "due_date: #{due_date}"
    
    (due_date < today)
  end

  def self.last_of_the_month(dt)
    dt_ = dt +1
    # does month change by adding 1 day?
    puts 'IS LAST_OF_THE_MONTH' if dt.month != dt_.month
    puts 'IS NOT LAST_OF_THE_MONTH' if dt.month == dt_.month
    return dt.month != dt_.month
  end

  def self.last_of_the_year(dt)
    dt_ = dt + 1
    # does year change by adding 1 day?
    return dt.year != dt_.year
  end
end