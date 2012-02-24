class Task < ActiveRecord::Base

	validates_presence_of :title
	validates_numericality_of :percentage, {:only_integer => true}

	belongs_to :user
	belongs_to :project

	scope :nearly_completed, :conditions => ["percentage >= ?", 90]
	scope :not_assigned, :conditions => ["user_id IS NULL"]
	scope :assigned, :conditions => ["user_id NOT NULL"]
	scope :almost_due, lambda{ 
		{:conditions => ["due_at < ?", 7.days.from_now]}
	}

	scope :for_user, lambda{ |user|
		{:conditions => ["user_id = ?",user.id]}
	}

end
