class Course < ActiveRecord::Base
  belongs_to :user
  has_many :classmate_courses
  has_many :classmates, :through => :classmate_courses

  validates :title, :presence=>true
  validates :title, uniqueness: { scope: :user }

  def self.search(query)
    if !!query
      self.where("title LIKE ?", "%#{query}%")
    else 
      self.all
    end
  end

end
