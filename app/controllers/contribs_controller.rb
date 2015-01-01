class ContribsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_contrib, only: [:show, :edit, :update, :destroy]
  before_action :owns_contrib, only: [:edit, :update, :destroy]

  # GET /contribs
  # GET /contribs.json
  def index
    @contribs = Contrib.all
  end

  # GET /contribs/1
  # GET /contribs/1.json
  def show
  end

  # GET /contribs/new
  def new
    @contrib = Contrib.new
  end

  # GET /contribs/1/edit
  def edit
  end

  # POST /contribs
  # POST /contribs.json
  def create
    @contrib = Contrib.new(contrib_params)
    @contrib.user = current_user

    respond_to do |format|
      if @contrib.save
        format.html { redirect_to @contrib, notice: 'Contrib was successfully created.' }
        format.json { render :show, status: :created, location: @contrib }
      else
        format.html { render :new }
        format.json { render json: @contrib.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contribs/1
  # PATCH/PUT /contribs/1.json
  def update
    respond_to do |format|
      if @contrib.update(contrib_params)
        format.html { redirect_to @contrib, notice: 'Contrib was successfully updated.' }
        format.json { render :show, status: :ok, location: @contrib }
      else
        format.html { render :edit }
        format.json { render json: @contrib.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contribs/1
  # DELETE /contribs/1.json
  def destroy
    @contrib.destroy
    respond_to do |format|
      format.html { redirect_to contribs_url, notice: 'Contrib was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contrib
      @contrib = Contrib.find(params[:id])
    end

    def owns_contrib
      if !user_signed_in? || current_user != @contrib.user
        begin
          redirect_to :back, flash: { error: "You can only do this on things you own." }
        rescue ActionController::RedirectBackError
          redirect_to contribs_path
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contrib_params
      params.require(:contrib).permit(:title, :description)
    end
end
