class ContribsController < PartipsController
  # GET /contribs/new
  def new
    super

    if Interest.exists?(:id => params[:in_reply_to])
      @contrib.interest = Interest.find(params[:in_reply_to])
    end
  end
end
