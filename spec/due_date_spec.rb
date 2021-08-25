require 'rspec'
require './spec/spec_helper.rb'

describe CbDeletionDateEstimate do
  describe ".is_due?" do
    it "validates inputs" do
      tomorrow = (Date.today) +1
      yesterday = (Date.today) -1
      existing_retention_plan = 'STANDARD'
      non_existing_retention_plan = 'COPPER'

      expect { CbDeletionDateEstimate.is_due?(non_existing_retention_plan,tomorrow) }.to raise_error(ArgumentError)
      expect { CbDeletionDateEstimate.is_due?(non_existing_retention_plan, yesterday) }.to raise_error(ArgumentError)
      expect { CbDeletionDateEstimate.is_due?(existing_retention_plan, yesterday) }.to_not raise_error
    end

    it 'calculates properly for Standard Retention Plan' do
      due_date = (Date.today) - 43
      undue_date = (Date.today) -1
      retention_plan = 'StaNdard'

      expect(CbDeletionDateEstimate.is_due?(retention_plan,due_date)).to be true
      expect(CbDeletionDateEstimate.is_due?(retention_plan,undue_date)).to be false
    end

    it 'calculates properly for Gold Retention Plan' do
      undue_date = (Date.today) -1
      due_date = (Date.new(((undue_date.year) -1), (undue_date.month))) - 43
      retention_plan = 'GOLd'

      expect(CbDeletionDateEstimate.is_due?(retention_plan,due_date)).to be true
      
      expect(CbDeletionDateEstimate.is_due?(retention_plan,undue_date)).to be false

      due_date = (Date.new(undue_date.year,undue_date.month).prev_month) -1
      expect(CbDeletionDateEstimate.is_due?(retention_plan,due_date)).to be false
      
      due_date = (Date.new(undue_date.year,undue_date.month).prev_month) - 366
      expect(CbDeletionDateEstimate.is_due?(retention_plan,due_date)).to be true
    end
end
  
end