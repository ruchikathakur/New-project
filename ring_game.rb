class RingGame < ActiveRecord::Base

	enum ring_type: {company: 1, personal: 2, location: 3}

	belongs_to :user, :foreign_key => 'created_by'
	belongs_to :user, :foreign_key => 'winner_id'

	has_and_belongs_to_many :users
	has_and_belongs_to_many :locations
	has_many :bonus_rings
	accepts_nested_attributes_for :bonus_rings, :allow_destroy => true

	validates_presence_of :start_date, :end_date, :award_1
	validates_presence_of :users, :if => :ring_type_presence
	scope :active, -> { where(winner_id: nil) }

	def ring_type_presence
		
		if(ring_type != "location")
			return true
		end
	end
end