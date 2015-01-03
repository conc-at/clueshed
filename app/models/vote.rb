class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :contrib
  belongs_to :interest

  before_validation :derivation
  validates :uid, uniqueness: true
  validate :has_one_partip
  validates_presence_of :user_id

  def derivation
    self.uid = "#{self.user_id}_#{partip_type}_#{partip_id}"
  end

  private
    def has_one_partip
      unless (!self.interest.nil? and self.contrib.nil?) or (!self.contrib.nil? and self.interest.nil?)
        errors.add(:base, "You must have exactly one Contrib or Interest.")
      end
    end

    def partip_id
      if self.interest
        self.interest.id
      elsif self.contrib
        self.contrib.id
      else
        nil
      end
    end

    def partip_type
      if self.interest
        'interest'
      elsif self.contrib
        'contrib'
      else
        nil
      end
    end
end
