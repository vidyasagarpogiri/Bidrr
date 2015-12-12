class Bid < ActiveRecord::Base
  belongs_to :list 
  belongs_to :user

  validates :amount, presence: true

  
end
