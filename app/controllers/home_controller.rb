class HomeController < ApplicationController
  def index
    @contrib = Contrib.new
    @interest = Interest.new
  end
end
