class Bid < ActiveRecord::Base
  belongs_to :list 
  belongs_to :user

  validates :amount, presence: true
  # validate :amount_greater_than_current_price
  # validate :current_user_is_not_list_user
end
