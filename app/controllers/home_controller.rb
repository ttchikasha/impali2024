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

  def online_application
    @online_application = OnlineApplication.new
    render :layout => "staff"
  end
end
