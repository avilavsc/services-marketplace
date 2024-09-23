class HomeController < ApplicationController
  def index
    @featured_services = Service.limit(3)
  end
end
