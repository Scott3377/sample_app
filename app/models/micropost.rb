class Micropost < ActiveRecord::Base
	belongs_to :user
	attr_accessible :content

	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 140 }

	default_scope order: 'microposts.created_at DESC'

	# Returns the microposts from the users being followed by the given user
	def self.from_users_followed_by(user)
		#followed_user_ids = user.followed_user_ids
		followed_user_ids = "SELECT followed_id FROM relationships 
							 WHERE follower_id = :user_id"
		#where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
	end
end
