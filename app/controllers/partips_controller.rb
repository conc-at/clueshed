# This Controller is abstract
# As Contribs and Interests are mostly the same and they share a lot
# Partips (i.e. Participations) act as the super class for both of them.

class PartipsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_signup_complete, except: [:index, :show]
  before_action :set_partip, only: [:show, :edit, :update, :destroy]
  before_action :owns_partip, only: [:edit, :update, :destroy]
  before_action :partips, only: [:index]

  # GET /partips
  # GET /partips.json
  def index
    respond_to do |format|
      format.html { redirect_to :root }

      objects = model.all
      instance_variable_set "@#{controller_name}", objects
      format.json { render }
    end
  end

  # GET /partips/1
  # GET /partips/1.json
  def show
  end

  # GET /partips/new
  def new
    instance model.new
  end

  # GET /partips/1/edit
  def edit
  end

  # POST /partips
  def create
    instance model.new partip_params
    instance.user = current_user

    if instance.save
      redirect_to instance, notice: "#{model_name} was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /partips/1
  def update
    if instance.update(partip_params)
      redirect_to instance, notice: "#{model_name} was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /partips/1
  def destroy
    instance.destroy
    redirect_to partips_path, notice: "#{model_name} was successfully destroyed."
  end

  private
    def model_name
      controller_name.classify
    end

    def model
      model_name.constantize
    end

    def instance_name
      controller_name.singularize
    end

    def instance(*args)
      if args.length == 0
        instance_variable_get "@#{instance_name}"
      else
        instance_variable_set "@#{instance_name}", args[0]
      end
    end

    def partips_path
      method("#{controller_name}_path").call
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_partip
      instance model.find(params[:id])
    end

    def owns_partip
      if !user_signed_in? || current_user != instance.user
        begin
          redirect_to :back, flash: { error: "You don't have permission to change this #{model_name}" }
        rescue ActionController::RedirectBackError
          redirect_to partips_path
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def partip_params
      params.require(instance_name.to_sym).permit(:title, :description, :first_time_speaker, :interest_id)
    end
end
