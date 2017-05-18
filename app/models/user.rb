class User < ApplicationRecord
	before_save { email.downcase! }
	validates :name, presence: true,
	                 length: { minimum: 3, maximum: 20 },
	                 format: { with: /\A[\w\-]+\z/ },
	                 uniqueness: true
	validates :email, presence: true,
	                  length: { maximum: 50 },
	                  format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
	                  uniqueness: { case_sensitive: false }
	                  

end
