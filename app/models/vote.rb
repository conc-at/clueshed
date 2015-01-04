class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :contrib
  belongs_to :interest

  before_validation :derivation
  validates :uid, uniqueness: true
  validate :has_one_partip, :is_not_own_partip
  validates_presence_of :user_id

  def derivation
    self.uid = "#{self.user_id}_#{partip_type}_#{partip_id}"
  end

  def partip
    if self.interest
      self.interest
    elsif self.contrib
      self.contrib
    end
  end

  private
    def has_one_partip
      unless (!self.interest.nil? and self.contrib.nil?) or (!self.contrib.nil? and self.interest.nil?)
        errors.add(:base, "You must have exactly one Contrib or Interest.")
      end
    end

    def is_not_own_partip
      if self.user_id == partip.user.id
        errors.add(:base, "You must not vote on your own Contrib or Interest.")
      end
    end

    def partip_id
      partip.id unless partip.nil?
    end

    def partip_type
      partip.class.name.downcase unless partip.nil?
    end
end
