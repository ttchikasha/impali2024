class HomeController < ApplicationController
  def index
    @price = SchoolPayment.current
    @staff = StaffMembers.home
    @subjects = DisplaySubjects.home
  end

  def staff
    @staff = StaffMembers.all
    render :layout => 'staff.html.erb'
  end
end
