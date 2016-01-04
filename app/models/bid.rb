class Bid < ActiveRecord::Base
  belongs_to :list 
  belongs_to :user

  validates :amount, presence: true
  validate :greater_than_current_price

  def greater_than_current_price
      if !amount.blank? && amount < self.list.current_price.to_i
        errors.add(:amount, "Must be greater than current price")
    end
  end

end
