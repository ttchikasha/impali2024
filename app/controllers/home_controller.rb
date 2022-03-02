class HomeController < ApplicationController
  def index
    @price = SchoolPayment.current
  end

  def about
  end

  def contact
  end
end
