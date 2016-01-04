class List < ActiveRecord::Base

  AUCTION_DEFAULT_PRICE = 1

  belongs_to :user

  has_many :bids, dependent: :destroy
  has_many :bidding_users, through: :bids, source: :user

  validates :title, presence: true 
	validates :details, presence: true 
	validates :end_date, presence: true 
	validates :reserve_price, presence: true
  validate  :end_date_is_in_future

  before_create do
    self.current_price = AUCTION_DEFAULT_PRICE
  end

  def end_date_is_in_future
    if !end_date.blank? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end

  include AASM
  aasm whiny_transitions: false do
    state :published, initial: true
    state :reserve_met
    state :won
    state :canceled
    state :reserve_not_met

    event :publish do
      transitions from: :published, to: :reserve_met
    end

    event :cancel do
      transitions from: :reserve_met, to: :published
    end

    event :was_won do
      transitions from: :reserve_met, to: :won
    end
  end


end
