
class WelcomeController < ApplicationController
    skip_before_action :authenticate_user!
    before_action :confirm_admin_permissions, only: [:admin_users,:admin_edit, :admin_destroy]
    before_action :set_user, only: [:admin_edit, :admin_show_user, :admin_update_user, :admin_destroy]
    protect_from_forgery :except => [:sumo_success]

    include ApplicationHelper

  def release_of_liability
      @lesson = Lesson.find(params[:id])
      render 'release_of_liability', layout: 'liability_release_layout'
  end

  def new_hire_packet
    file = "public/Homewood-Hire-Packet-2016-2017.pdf"
    if File.exists?(file)
      send_file file, :type=>"application/pdf", :x_sendfile=>true
    else
      flash[:notice] = 'File not found'
      redirect_to :index
    end
  end

  def recommended_accomodations
    file = "public/Recommended-Accomodations-Homewood.pdf"
    if File.exists?(file)
      send_file file, :type=>"application/pdf", :x_sendfile=>true
    else
      flash[:notice] = 'File not found'
      redirect_to :index
    end
  end

  def avantlink
    render 'avantlink_confirmation.txt', :layout => false
  end

  def ghost_click
    render 'ghost_click', :layout => false 
  end

  def index
    @lesson = Lesson.new
    # @lesson_time = @lesson.lesson_time
  end

  def sumo_success
    email=params[:email]
    LessonMailer.notify_sumo_success(email).deliver
    flash[:notice] = 'Thank you for subscribing! You can expect to receive a weekly email from us with useful tips for planning your next ski vacation. If you have any immediate questions, feel free to send a chat message using the widget below, or email us at support@snowschoolers.com.'
      flash[:sumo_success] = 'TRUE'
    redirect_to :index
  end

  def jackson_hole
  end

  def beginners_guide_to_tahoe
  end

  def learn_to_ski_packages
  end

  def snow_schoolers_referral
    resort = "Snow Schoolers Private Lessons"
    user = current_user ? current_user.email : "Unknown User"
    GoogleAnalyticsApi.new.event('tracked-referrals', "granlibakken-referral-to-snowschoolers")
    LessonMailer.notify_resort_referral(resort,user).deliver
    redirect_to "https://www.snowschoolers.com/granlibakken"
  end    

  def tahoedaves_referral
    GoogleAnalyticsApi.new.event('tracked-referrals', "custom-tahoe_daves")
    LessonMailer.notify_tahoedaves_referral.deliver
    redirect_to "https://rentals.tahoedaves.com/?utm_campaign=granlibakken_lessons"
  end  

  def about_us
  end

  def launch_announcement
  end

  def road_conditions
  end

  def accommodations
  end

  def resorts
  end

  def admin_users
    @users = User.all.sort {|a,b| a.id <=> b.id}
    @exported_users = User.all
    respond_to do |format|
          format.html
          format.csv { send_data @exported_users.to_csv, filename: "all_users-#{Date.today}.csv" }
          format.xls
    end
  end

  def admin_edit
  end

  def admin_update_user
    if @user.update(user_params)
        redirect_to admin_users_path, notice: 'User was successfully updated. If email was changed, it will need to be confirmed.'
    else
      Rails.logger.info(@user.errors.inspect)
      redirect_to admin_edit_user_path(@user), notice: "Unsuccessful. Error: #{@user.errors.full_messages}"
    end
  end

  def admin_show_user
    redirect_to admin_users_path
  end

   def admin_destroy
    @user.destroy
    redirect_to admin_users_path
   end


  def apply
    @instructor = Instructor.new
    GoogleAnalyticsApi.new.event('instructor-recruitment', 'load-application-page')
    # if current_user.nil?
    #     LessonMailer.track_apply_visits.deliver
    #   else
    #     LessonMailer.track_apply_visits(current_user.email).deliver
    # end
  end

  def notify_admin
    if request.xhr?
      first_name = params[:first_name]
      last_name = params[:last_name]
      email = params[:email]
      if current_user.nil?
        LessonMailer.application_begun(email, first_name, last_name).deliver
      else
        LessonMailer.application_begun(current_user.email).deliver
      end
      render json: {notice: "Email has been validated."}
    end
  end

  def march_madness
    render 'march-madness'
  end

  def team_offsites
    render 'team-offsites'
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :user_type, :location_id, :password, :password_confirmation, :current_password)
    end

end
