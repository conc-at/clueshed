class HomeController < ApplicationController
  def index
    @contribs = Contrib.all
    @contrib = Contrib.new
    @interests = Interest.all
    @interest = Interest.new
  end
end
