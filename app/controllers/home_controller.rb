class HomeController < ApplicationController
  def index
    @price = SchoolPayment.current
    @staff = StaffMembers.home
    @subjects = DisplaySubjects.juniors.reject { |s| s[:name] == "ICT" || s[:name] == "Guidance and Counselling" }.sample 8
  end

  def staff
    @staff = StaffMembers.all
    render :layout => "staff.html.erb"
  end

  def online_application
    @online_application = OnlineApplication.new
    render :layout => "staff"
  end
end
