class PagesController < ApplicationController
  def main
    @season = Season.current
  end
end
