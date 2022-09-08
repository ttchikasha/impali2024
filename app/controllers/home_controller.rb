class HomeController < ApplicationController
  def index
    @price = SchoolPayment.current
    @staff = StaffMembers.all
  end

  def about
  end

  def contact
  end
end
