class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :contrib
  belongs_to :interest

  before_validation :derivation
  validates :uid, uniqueness: true
  validate :one_partip?, :not_own_partip?
  validates_presence_of :user_id

  def partip
    interest || contrib
  end

  private
    def derivation
      self.uid = "#{user_id}_#{partip_type}_#{partip_id}"
    end

    def one_partip?
      unless !interest ^ !contrib
        errors.add(:base, "You must have exactly one Contrib or Interest.")
      end
    end

    def not_own_partip?
      if user_id == partip.user.id
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
