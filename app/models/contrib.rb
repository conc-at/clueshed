class Contrib < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  belongs_to :interest
  belongs_to :user
end
