class ContribsController < PartipsController
  # GET /contribs/new
  def new
    super

    # Interest.exists?(params[:in_reply_to])
    # aber: per bspw. find_by oder find_by_id könnte man sich auch den zusätzlichen DB-Call sparen
    if Interest.exists?(:id => params[:in_reply_to])
      @contrib.interest = Interest.find(params[:in_reply_to])
    end
  end
end
