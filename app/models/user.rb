class User < ApplicationRecord
    has_many :reservations
  
    validates :name, presence: true
    validates :role, inclusion: { in: %w(admin customer) }
  
    enum role: { customer: 'customer', admin: 'admin' }
  end