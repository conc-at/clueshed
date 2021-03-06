class Contrib < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  belongs_to :interest
  has_many :votes
  belongs_to :user
end
