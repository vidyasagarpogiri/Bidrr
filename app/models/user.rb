class User < ActiveRecord::Base
	has_secure_password
	has_many :list, dependent: :destroy

	has_many :bids, dependent: :destroy
  has_many :bidded_lists, through: :bids, source: :list


	validates :email, presence: true,
														format:  {with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
													
	validates :first_name, presence: true
	validates :last_name, presence: true

	def full_name
  	"#{first_name} #{last_name}"
	end

	private
end
