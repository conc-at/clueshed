class HomeController < ApplicationController
  before_action :partips

  def index
    @contrib = Contrib.new
    @interest = Interest.new
  end
end
