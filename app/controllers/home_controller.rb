class HomeController < ApplicationController
  def index
    @price = SchoolPayment.current
    @staff = StaffMembers.all
  end

  def staff
    @staff = StaffMembers.all
    render :layout => 'staff.html.erb'
  end
end
