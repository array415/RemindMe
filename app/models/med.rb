class Med < ApplicationRecord
  belongs_to :user
  has_many :alerts

  validates_presence_of :med_name 
end
