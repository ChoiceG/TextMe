class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
  # Use to prevent our own name from appearing as list of users, so you cannot dm self
  scope :all_except, -> (user) { where.not(id: user)}
  # Ex:- scope :active, -> {where(:active => true)}
end
