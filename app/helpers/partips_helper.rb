module PartipsHelper
  def has_voted(partip)
    Vote.exists?(:uid => uid(partip))
  end

  def vote_id(partip)
    if has_voted partip
      Vote.where(:uid => uid(partip))[0].id
    end
  end

  private
    def uid(partip)
      "#{current_user.id}_#{partip.class.name.downcase}_#{partip.id}"
    end
end
