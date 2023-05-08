class User < ApplicationRecord

    enum role: { basic: 0, moderator: 1, admin: 2}, _suffix: :role
    
    has_secure_password
    
    validates :email, presence: true, uniqueness: true
end
