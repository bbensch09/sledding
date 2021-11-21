class LessonsController < ApplicationController
  respond_to :html
  skip_before_action :authenticate_user!, only: [:new, :new_specific_slot, :new_request, :create, :complete, :confirm_reservation, :update, :show, :edit, :complete_lift_ticket, :complete_snowplay_ticket, :create_nye_sledding_ticket, :complete_nye_2020, :create_wed_sledding_ticket, :complete_wednesday_special, :destroy, :view_cart]
  skip_before_action :verify_authenticity_token, only: [:confirm_reservation, :create, :update]
  before_action :confirm_admin_permissions, except: [:schedule, :book_product, :new, :new_request, :new_specific_slot, :create, :complete, :edit, :update, :confirm_reservation, :show, :index, :issue_full_refund, :complete_lift_ticket, :complete_snowplay_ticket, :create_nye_sledding_ticket, :complete_nye_2020, :create_wed_sledding_ticket, :complete_wednesday_special, :destroy, :view_cart]
  before_action :set_lesson, only: [:show, :duplicate, :complete, :update, :edit, :admin_confirm_deposit, :admin_reconfirm_state,:set_admin_skip_validations, :confirm_reservation, :issue_full_refund]
  before_action :set_admin_skip_validations, only: [:update, :confirm_reservation]
  # before_action :save_lesson_params_and_redirect, only: [:create]
  # before_action :create_lesson_from_session, only: [:create]

  def sledding_check_in
      @lesson = Lesson.find(params[:id])
      @lesson.check_in_status = 'checked-in'
      @lesson.save
      redirect_back(fallback_location: lessons_path)
  end

  def sledding_check_in_reverse
      @lesson = Lesson.find(params[:id])
      @lesson.check_in_status = nil
      @lesson.save
      redirect_back(fallback_location: lessons_path)
  end

  def assign_to_section
    puts "the params are #{params}"
    @lesson = Lesson.find(params[:lesson_id])
    @section = Section.find(params[:section_id])
    @lesson.section_id = @section.id
    @lesson.save!
    redirect_to "/schedule-filtered?utf8=✓&search_date=#{@section.parametized_date}&age_type=#{@section.age_group}"
  end

  def admin_index
    # Lesson.set_dates_for_sample_bookings
    @lessons_to_export = Lesson.where(state:"confirmed")
    # could modify this manually if we want a full export of all bookings to be loaded in the browser
    @lessons = Lesson.last(200).to_a.keep_if{|lesson| lesson.lesson_time && lesson.completed? || lesson.completable? || lesson.confirmable? || lesson.confirmed? || lesson.finalizing? || lesson.booked? || lesson.payment_complete? || lesson.ready_to_book? || lesson.waiting_for_review?}
    @lessons = @lessons.sort! { |a,b| b.lesson_time.date <=> a.lesson_time.date }
    @show_search_options = true
    respond_to do |format|
          format.html {render 'admin_index'}
          format.csv { send_data @lessons_to_export.to_csv, filename: "sledding-emails-export-#{Date.today}.csv" }
    end
  end

  def all_sledding_sales
    # Lesson.set_dates_for_sample_bookings
    @lessons = Lesson.where(state:"confirmed")
    # could modify this manually if we want a full export of all bookings to be loaded in the browser
    # @lessons = Lesson.last(2)
    # @lessons = @lessons.sort! { |a,b| b.lesson_time.date <=> a.lesson_time.date }
    respond_to do |format|
          format.html {render 'all_sledding_sales'}
          format.csv { send_data @lessons_to_export.to_csv, filename: "sledding-emails-export-#{Date.today}.csv" }
    end
  end
  

  def roster_today
    # Lesson.set_dates_for_sample_bookings
    @lessons_to_export = Lesson.all.select{|lesson| lesson.state == "confirmed" && lesson.date == Date.today}
    @lessons = Lesson.all.select{|lesson| lesson.completed? || lesson.completable? || lesson.confirmable? || lesson.confirmed? || lesson.finalizing? || lesson.booked? || lesson.payment_complete? || lesson.waiting_for_review?}
    @lessons = @lessons.select{ |lesson| lesson.date == Date.today}
    @lessons = @lessons.sort! { |a,b| a.id <=> b.id }
    respond_to do |format|
          format.html {render 'admin_index'}
          format.csv { send_data @lessons_to_export.to_csv, filename: "group-lessons-export-#{Date.today}.csv" }
    end
  end

  def roster_today_print
    @lessons = Lesson.all.select{|lesson| lesson.completed? || lesson.completable? || lesson.confirmable? || lesson.confirmed? || lesson.finalizing? || lesson.booked? || lesson.payment_complete? || lesson.waiting_for_review?}
    @lessons = @lessons.select{ |lesson| lesson.date == Date.today}
    @lessons = @lessons.sort! { |a,b| a.id <=> b.id }
    respond_to do |format|
          format.html {render 'admin_index', layout: 'liability_release_layout'}
    end
  end

  def roster_tomorrow
    # Lesson.set_dates_for_sample_bookings
    @date = params[:date]
    @date.nil? ? @date = Date.today+2 : @date.to_date
    @lessons_to_export = Lesson.all.select{|lesson| lesson.state == "confirmed" && lesson.date == @date}
    @lessons = Lesson.all.select{|lesson| lesson.state == "confirmed" && lesson.date.to_s == @date}
    # @lessons = Lesson.all.select{|lesson| lesson.state == "confirmed"}
    @lessons = @lessons.sort! { |a,b| a.id <=> b.id }
    respond_to do |format|
          format.html {render 'admin_index'}
          format.csv { send_data @lessons_to_export.to_csv, filename: "group-lessons-export-#{Date.today}.csv" }
    end
  end

  def roster_tomorrow_print
    @lessons = Lesson.all.select{|lesson| lesson.completed? || lesson.completable? || lesson.confirmable? || lesson.confirmed? || lesson.finalizing? || lesson.booked? || lesson.payment_complete? || lesson.waiting_for_review?}
    @lessons = @lessons.select{ |lesson| lesson.date == Date.tomorrow}
    @lessons = @lessons.sort! { |a,b| a.id <=> b.id }
    respond_to do |format|
          format.html {render 'admin_index', layout: 'liability_release_layout'}
    end
  end

  def lift_tickets_today
    # Lesson.set_dates_for_sample_bookings
    @tickets_to_export = Lesson.all.select{|lesson| lesson.deposit_status == "confirmed" && lesson.activity == "lift_ticket" && lesson.date == Date.today}
    @tickets = @tickets_to_export
    @tickets = @tickets.sort! { |a,b| a.id <=> b.id }
    respond_to do |format|
          format.html {render 'lift_tickets_roster'}
          format.csv { send_data @tickets_to_export.to_csv, filename: "lift-tickets-export-#{Date.today}.csv" }
    end
  end

  def all_lift_tickets
    @tickets_to_export = Lesson.all.select{|lesson| lesson.deposit_status == "confirmed" && lesson.activity == "lift_ticket"}
    @tickets = @tickets_to_export
    @tickets = @tickets.sort! { |a,b| a.id <=> b.id }
    respond_to do |format|
          format.html {render 'lift_tickets_roster'}
          format.csv { send_data @tickets_to_export.to_csv, filename: "lift-tickets-export-#{Date.today}.csv" }
    end

  end


  def capacity_last_next_14
    if params[:date]
        min_date = params[:date].to_date
    else min_date = Date.today - 3
    end
    max_date = min_date + 16
    lessons = Lesson.all.select{|lesson| lesson.completed? || lesson.completable? || lesson.confirmable? || lesson.confirmed? || lesson.booked? }
    lessons = lessons.select{ |lesson| lesson.date >= min_date && lesson.date <= max_date}
    @lessons = lessons.sort_by{|lesson| lesson.date}
    @count = @lessons.count
    dates = []
    (0..16).each do |x|
      dates << min_date + x
    end
    @dates = dates    
    render 'capacity_calendar'
  end

  def admin_index_all
    @lessons_to_export = Lesson.where(state:"confirmed")
    @lessons = Lesson.where(state:"confirmed").to_a
    @lessons = @lessons.sort! { |a,b| a.lesson_time.date <=> b.lesson_time.date }
    @show_search_options = true
    respond_to do |format|
          format.html {render 'admin_index'}
          format.csv { send_data @lessons_to_export.to_csv, filename: "group-lessons-export-#{Date.today}.csv" }
    end
  end

  def schedule
      # @lessons = Lesson.all.to_a.keep_if{|lesson| lesson.completed? || lesson.completable? || lesson.confirmable? || lesson.confirmed?}
      render 'schedule_new'
  end

  def assign_all_instructors_to_sections
    Lesson.assign_all_instructors_to_sections
    redirect_to '/sections'
  end

  def filtered_lesson_reservations
    search_params = {email: params[:search], name: params[:name], date: params[:date], gear:params[:gear]}
    puts "!!!!! the search_params are: #{search_params}"
    @lessons = Lesson.all
    if params[:date] != ""
        puts "!!!filter by date.  param is #{params['date']}"
        @lessons = @lessons.to_a.keep_if{|lesson| lesson.date && lesson.date.to_s == params[:date]}
        puts "found #{@lessons.count} mactching lessons"
    end
    if params[:name] != ""
        puts "!!!filter by name.  param is #{params['name']}"
        @lessons = @lessons.to_a.keep_if{|lesson| lesson.name == params[:name]}
        puts "found #{@lessons.count} mactching lessons"
    end
    if params['email'] != ""
        puts "!!!filter by email. email param is #{params['email']}"
        @lessons = @lessons.to_a.keep_if{|lesson| lesson.email == params[:email]}
        # @lessons = Lesson.all.select{|lesson| lesson.email == 'brian@snowschoolers.com'}
        puts "found #{@lessons.count} mactching lessons"
    end
    if params['gear'] == "on"
        puts "!!!filtering for resrations with rentals."
        @lessons = @lessons.to_a.keep_if{|lesson| lesson.gear == true}
        puts "found #{@lessons.count} mactching lessons"
    end
    puts "!!!! @lessons.count is #{@lessons.count}"
    @lessons = @lessons.keep_if{|lesson| lesson.completed? || lesson.completable? || lesson.confirmable? || lesson.confirmed? || lesson.finalizing? || lesson.booked? || lesson.payment_complete? || lesson.ready_to_book? || lesson.waiting_for_review?}
    render 'admin_index'
  end

  def filtered_schedule_results
      date = params[:date]
      puts "!!! filtere date: #{date}"
      all_days = Section.select(:date).distinct
      @days = all_days.to_a.keep_if{|a| a.date.to_s == params[:date]}
      puts "!!!filter by date.  param is #{params['date']}"
      @lessons = Lesson.all.to_a.keep_if{|lesson| lesson.date.to_s == params[:date]}
        puts "found #{@lessons.count} mactching lessons"
      @new_date = Section.new
      render 'index'
  end

  def index
    if current_user && (current_user.user_type == 'Ski Area Partner' || current_user.user_type == "Granlibakken Employee" || current_user.email == 'brian@snowschoolers.com')
      all_days = Section.select(:date).distinct.sort{|a,b| a.date <=> b.date}
      @days = all_days.keep_if{|a| a.date >= Date.today}
      @days = @days.first(30)
      @new_date = Section.new
      @lessons = Lesson.all.to_a.keep_if{|lesson| lesson.completed? || lesson.completable?}
      @lessons.sort! { |a,b| a.lesson_time.date <=> b.lesson_time.date }
      if session[:notice]
        flash.now[:notice] = session[:notice]
      end
    elsif current_user
        @lessons = Lesson.where(requester_id:current_user.id)
        if @lessons.count > 0
          @new_date = Section.new
          days =[]
          @lessons.each do |lesson|
            days << Section.select(:date).where(date:lesson.lesson_time.date).first
          end
          @days = days
          render 'index'
        else
          redirect_to root_path
          flash[:notice] = "You do not have permission to view that page."
        end
    end
  end

  def send_reminder_sms_to_instructor
    @lesson = Lesson.find(params[:id])
    if @lesson.instructor.nil?
      puts "!!!instructor = nil"
      instructor = Instructor.find(params[:instructor_id])
      @lesson.send_manual_sms_request_to_instructor(instructor)
    elsif @lesson.completable?
      puts "!!!instructor found, lesson is compeltable"
      @lesson.send_sms_reminder_to_instructor_complete_lessons
    end
    redirect_to @lesson
  end

  def sugarbowl
    @lesson = Lesson.new
    @promo_location = 9
    @lesson_time = @lesson.lesson_time
    render 'new'
  end

  def homewood
    @lesson = Lesson.new
    @promo_location = 6
    @lesson_time = @lesson.lesson_time
    render 'new'
  end

  def book_product
    @lesson = Lesson.new
    @promo_location = Product.find(params[:id]).location.id
    @slot = Product.find(params[:id]).name.to_s
    puts "The selected slot is #{@slot}"
    @lesson_time = @lesson.lesson_time
    render 'new'
  end

  def new
    @lesson = Lesson.new
    @promo_location = session[:lesson].nil? ? nil : session[:lesson]["requested_location"]
    @product_name = session[:lesson].nil? ? nil : session[:lesson]["product_name"]
    @activity = session[:lesson].nil? ? nil : session[:lesson]["activity"]
    @slot = (session[:lesson].nil? || session[:lesson]["lesson_time"].nil?) ? nil : session[:lesson]["lesson_time"]["slot"]
    @date = (session[:lesson].nil? || session[:lesson]["lesson_time"].nil?)  ? nil : session[:lesson]["lesson_time"]["date"]
    @lesson_time = @lesson.lesson_time
    GoogleAnalyticsApi.new.event('lesson-requests', 'load-lessons-new')
  end

  # def new_backup_oct22
  #   @lesson = Lesson.new
  # end


  def new_request
    puts "!!! processing instructor request; Session variable is: #{session[:lesson]}"
    @lesson = Lesson.new
    @promo_location = session[:lesson].nil? ? nil : session[:lesson]["requested_location"]
    @activity = session[:lesson].nil? ? nil : session[:lesson]["activity"]
    @slot = (session[:lesson].nil? || session[:lesson]["lesson_time"].nil?) ? nil : session[:lesson]["lesson_time"]["slot"]
    @date = (session[:lesson].nil? || session[:lesson]["lesson_time"].nil?)  ? nil : session[:lesson]["lesson_time"]["date"]
    @instructor_requested = Instructor.find(params[:id]).id
    @lesson_time = @lesson.lesson_time
    GoogleAnalyticsApi.new.event('lesson-requests', 'load-lessons-new-private-request')
    render 'new'
  end

  def new_specific_slot
    puts "!!!!session data includes: #{session[:activity]}"
    @lesson = Lesson.new
    @lesson.activity = session[:activity]
    @lesson.requested_location = 24
    @activity = session[:lesson].nil? ? nil : session[:lesson]["activity"]
    @slot = (session[:lesson].nil? || session[:lesson]["lesson_time"].nil?) ? nil : session[:lesson]["lesson_time"]["slot"]
    @date = (session[:lesson].nil? || session[:lesson]["lesson_time"].nil?)  ? nil : session[:lesson]["lesson_time"]["date"]
    @lesson.lesson_time = LessonTime.find_or_create_by(date:session[:date],slot:session[:slot])
    @lesson.save
    GoogleAnalyticsApi.new.event('lesson-requests', 'load-full-form')
    render 'complete'
  end

  def create
      puts "!!!!!!!!! Lesson params are \n #{params}"
      @lesson = Lesson.new(lesson_params)
      @lesson.requester = current_user
      @lesson.requested_location = 24
      temp_slot = params[:lesson]["lesson_time"]["slot"]
      if LIFT_TICKET_SLOTS.include?(temp_slot)
        @lesson.activity = 'lift_ticket'
        elsif SNOWPLAY_SLOTS.include?(temp_slot)
        @lesson.activity = 'snowplay'
        else
        @lesson.activity = 'sledding'
      end
      @lesson.lesson_time = @lesson_time = LessonTime.find_or_create_by(lesson_time_params)
    if @lesson.slot == 'Saturday Dusk (4:30-6pm)' || @lesson.slot == 'Spicy Saturday Night (6:30-8pm)'
          @lesson.package_info = "Spicy Saturdays"
    end
    if current_user && (current_user.email == 'brian@snowschoolers.com' || current_user.user_type == 'Granlibakken Employee')
      puts "!!!current user is admin, preparing to set skip_validations boolean to true."
      session[:skip_validations] = true
      @lesson.skip_validations = true
    end

    if @lesson.save
      @user_email = current_user ? current_user.email : "unknown"
      if @lesson.activity == 'sledding'
        redirect_to complete_lesson_path(@lesson)
        elsif @lesson.activity == 'snowplay'
        redirect_to complete_snowplay_ticket_path(@lesson)
        elsif @lesson.activity == 'lift_ticket'
        redirect_to complete_lift_ticket_path(@lesson)
        # LessonMailer.notify_admin_lesson_request_begun(@lesson, @user_email).deliver
      end
      else
      flash[:notice] = 'Unfortunately, there has been a problem.'
      render 'new'
    end

  end

  def create_nye_sledding_ticket
    days_til_sat = 6 - Date.today.wday
    promo_date = Date.today + days_til_sat
    nye_params = {
      date:promo_date.to_s,
      slot:NYE_SLOTS.first,
    }
    @lesson = Lesson.new
    @lesson.lesson_time = @lesson_time = LessonTime.find_or_create_by(nye_params)
    @lesson.package_info = "Spicy Saturdays"
    @lesson.activity = "sledding"
    @slot = @lesson_time.slot
    @lesson.requested_location = 24
    if @lesson.save
        redirect_to complete_nye_2020_path(@lesson)
        # flash[:notice] = "Almost there! We just need a few more details."
    else
        # flash[:alert] = "Unfortunately that sledding session is already at capacity. Please pick another time."
        render 'new'
    end
  end


  def complete_nye_2020
    @lesson = Lesson.find(params[:id])
    @product_name = "Spicy Saturdays"
    # @date = "2020-12-31"
    # @slot = NYE_SLOTS.first
    @promo_code = "Saturday"
    # GoogleAnalyticsApi.new.event('lesson-requests', 'load-full-form')
    flash.now[:notice] = "Thanks for planning to spend Saturday Night at Granlibakken. We just need a few more details."
    flash[:complete_form] = 'TRUE'
    render 'full_sledding_form'

  end

  def create_wed_sledding_ticket
    days_til_wed = 3 - Date.today.wday
    promo_date = Date.today + days_til_wed
    nye_params = {
      date:promo_date.to_s,
      slot:AFTERSCHOOL_SLOTS.first,
    }
    @lesson = Lesson.new
    @lesson.lesson_time = @lesson_time = LessonTime.find_or_create_by(nye_params)
    @lesson.package_info = "Afterschool Special"
    @lesson.activity = "sledding"
    @slot = @lesson_time.slot
    @lesson.requested_location = 24
    if @lesson.save
        redirect_to complete_wednesday_special_path(@lesson)
        # flash[:notice] = "Almost there! We just need a few more details."
    else
        # flash[:alert] = "Unfortunately that sledding session is already at capacity. Please pick another time."
        render 'new'
    end
  end


  def complete_wednesday_special
    @lesson = Lesson.find(params[:id])
    @product_name = "Afterschool Special"
    # @date = "2020-12-31"
    # @slot = NYE_SLOTS.first
    @promo_code = "Afterschool Special"
    # GoogleAnalyticsApi.new.event('lesson-requests', 'load-full-form')
    flash.now[:notice] = "Thanks for planning to spend your Wednesday afternoon at Granlibakken. We just need a few more details."
    flash[:complete_form] = 'TRUE'
    render 'full_sledding_form'

  end


  def complete
    @lesson = Lesson.find(params[:id])
    @product_name = @lesson.product_name
    unless @lesson.lesson_time.nil?
      @date = @lesson.lesson_time.date
      @slot = @lesson.slot
    end
    if @lesson.package_info == "Spicy Saturdays"
          @promo_code = "Saturday"
        else
      @promo_code = PromoCode.new
    end
    # GoogleAnalyticsApi.new.event('lesson-requests', 'load-full-form')
    flash.now[:notice] = "You're almost there! We just need a few more details."
    flash[:complete_form] = 'TRUE'
    render 'full_sledding_form'
  end

  def complete_lift_ticket
    @lesson = Lesson.find(params[:id])
    @product_name = @lesson.product_name
    unless @lesson.lesson_time.nil?
      @date = @lesson.lesson_time.date
      @slot = @lesson.slot
    end
    @promo_code = PromoCode.new
    # GoogleAnalyticsApi.new.event('lesson-requests', 'load-full-form')
    flash.now[:notice] = "You're almost there! We just need a few more details."
    flash[:complete_form] = 'TRUE'
    render 'full_lift_ticket_form'
  end

  def complete_snowplay_ticket
    @lesson = Lesson.find(params[:id])
    @product_name = @lesson.product_name
    @date = @lesson.lesson_time.date
    @slot = @lesson.slot
    @promo_code = PromoCode.new
    # GoogleAnalyticsApi.new.event('lesson-requests', 'load-full-form')
    flash.now[:notice] = "You're almost there! We just need a few more details."
    flash[:complete_form] = 'TRUE'
    render 'full_snowplay_form'
  end

  def edit
    @lesson = Lesson.find(params[:id])
    @lesson_time = @lesson.lesson_time
    @slot = @lesson.lesson_time.slot
    @date = @lesson.lesson_time.date
    @state = @lesson.instructor ? 'pending instructor' : @lesson.state
    if @lesson.activity == 'sledding'
        redirect_to complete_lesson_path(@lesson)
      elsif @lesson.activity == 'snowplay'
        redirect_to complete_snowplay_ticket_path(@lesson)
      elsif @lesson.activity == 'lift_ticket'
        redirect_to complete_lift_ticket_path(@lesson)
      else
        redirect_to complete_lesson_path(@lesson)
    end
  end

  def view_cart
    if current_shopping_cart.empty?
      if current_user
        @orders = current_user.shopping_carts.select{|sc| sc.status == 'purchased'}
        @lessons = []
        @orders.each do |order| 
          order.lessons.each do |lesson|
            @lessons << lesson
          end
        end
      end
      render 'view_all_orders'
    else
      @lesson = current_shopping_cart.ready_to_book.first
      render 'show'
    end
  end

  def reissue_invoice
    @lesson = Lesson.find(params[:id])
    @lesson_time = @lesson.lesson_time
    @date = @lesson_time.date
    @lesson.state = "ready_to_book"
    @lesson.deposit_status = nil
    @lesson.save
    render 'edit'
  end

  def issue_refund
    @lesson = Lesson.find(params[:id])
    @lesson_time = @lesson.lesson_time
    session[:refund] = true
    # render 'edit'
    if @lesson.activity == 'sledding'
      render 'full_sledding_form'
    elsif @lesson.activity == 'snowplay'
      render 'full_snowplay_form'
    elsif @lesson.activity == 'lift_ticket'
      render 'full_lift_ticket_form'
    else
      render 'full_sledding_form'
    end
  end

  def issue_full_refund
    @lesson = Lesson.find(params[:id])
    @lesson.skip_validations = true
    @lesson.state = 'Canceled - full refund issued.'
    @lesson.save
    session[:refund] = nil
    redirect_to @lesson
  end

  def confirm_reservation
    @lesson = Lesson.find(params[:id])
    if @lesson.deposit_status != 'confirmed'
        @amount = @lesson.price.to_i
        if @amount > 0
          customer = Stripe::Customer.create(
            :email => params[:stripeEmail],
            :source  => params[:stripeToken]
          )
          charge = Stripe::Charge.create(
            :customer    => customer.id,
            :amount      => @amount*100,
            :description => 'Sledding Hill Ticket',
            :currency    => 'usd'
          )
        end
        @lesson.deposit_status = 'confirmed'
        @lesson.state = 'confirmed'
        @lesson.shopping_cart.status = 'purchased'
        @lesson.shopping_cart.transaction_id = Time.now.to_i
        @lesson.shopping_cart.save!
    end
    if @lesson.save
      if @lesson.activity == 'sledding'
          LessonMailer.sledding_tickets_confirmation(@lesson).deliver!
          flash[:notice] = 'Thank you, your sledding tickets have been purchased successfully. You will receive an email notification momentarily. If you have any questions about your reservation, please email frontdesk@granlibakken.com.'
          flash[:conversion] = 'TRUE'
        elsif @lesson.activity == 'snowplay'
          LessonMailer.snowplay_tickets_confirmation(@lesson).deliver!
          flash[:notice] = 'Thank you, your snowplay tickets have been purchased successfully. You will receive an email notification momentarily. If you have any questions about your reservation, please email frontdesk@granlibakken.com.'
          flash[:conversion] = 'TRUE'
        elsif @lesson.activity == 'lift_ticket'
          LessonMailer.lift_tickets_confirmation(@lesson).deliver!
          flash[:notice] = 'Thank you, your lift tickets have been purchased successfully. You will receive an email notification momentarily. If you have any questions about your reservation, please email frontdesk@granlibakken.com.'
          flash[:conversion] = 'TRUE'
        else
      end
      if @lesson.promo_code
        LessonMailer.send_promo_redemption_notification(@lesson).deliver!
      end
      puts "!!!!!!!! Ticket deposit successfully charged"
      redirect_to @lesson
    else
      determine_update_state
      puts "!!!!!most likely charge was completed but lesson could not save due to capacity being reached."
      puts "!!!!!Ticket NOT saved, update notices determined by 'determine update state' method...?"
      redirect_to @lesson
    end
  end

  def duplicate
    new_lesson = @lesson.dup
    new_lesson.lesson_time =  @lesson.lesson_time #LessonTime.find_or_create_by(lesson_time_params)
    # new_lesson.students = @lesson.students
    @lesson.students.each do |student|
      Student.create!({
        name: student.name,
        age_range: student.age_range,
        gender: student.gender,        
        lesson_id: nil
      })
    end
    new_lesson.deposit_status = nil
    #erase previous lesson feedback & start/end times
    if new_lesson.save
      @lesson = new_lesson
      new_students = Student.where(lesson_id:nil)
      new_students.each do |student|
        student.lesson_id = @lesson.id
        student.save!
      end
      redirect_to "/lessons/#{@lesson.id}?state=#{@lesson.state}"
    else
      flash[:alert] = "Cannot duplicate this booking, as it would cause total bookings to exceed the capacity. Please try another day or time slot."
      redirect_to sledding_admin_index_path
    end
  end

  def update
    puts "!!!!!!begin update action -- shouuld have already passed validations"
    puts "!!!! counting the number of students attached to this order: #{params[:lesson][:students_attributes].keys.count}"
    cookies[:student_count] = {
      value: params[:lesson][:students_attributes].keys.count,
      expires: 1.year.from_now
    }
    @lesson = Lesson.find(params[:id])
    if session[:promo_code]
      puts "!!!!INSERT NEW LOGIC FOR PROMO CODE STRINGS"
      puts "lesson objectives string = #{@lesson.objectives}"
      if PromoCode.where(promo_code:@lesson.objectives).count >= 1
        puts "!!!found PromoCode matching lesson.objectives"
        pc_id = PromoCode.where(promo_code:@lesson.objectives).first.id
        @lesson.promo_code_id = pc_id
      end
    end
    @original_lesson = @lesson.dup
    @lesson.assign_attributes(lesson_params)
    @lesson.num_days = params[:lesson][:students_attributes].keys.count
    @lesson.lesson_time = @lesson_time = LessonTime.find_or_create_by(lesson_time_params)
    unless current_user && current_user.user_type == "Granlibakken Employee"
      @lesson.requester = current_user
    end
    unless @lesson.deposit_status == 'confirmed'
      @lesson.state = 'ready_to_book'
    end
    @shopping_cart = current_shopping_cart
    @lesson.shopping_cart_id = @shopping_cart.id
    if @lesson.save
      # GoogleAnalyticsApi.new.event('lesson-requests', 'full_sledding_form-updated', params[:ga_client_id])
      @user_email = current_user ? current_user.email : "unknown"
      if @lesson.state == "ready_to_book"
      # LessonMailer.notify_admin_lesson_full_sledding_form_updated(@lesson, @user_email).deliver!
      end
      puts "!!!! Lesson update saved; lesson state is #{@lesson.state}"
    redirect_to @lesson
    else
      determine_update_state
      @date = @lesson.lesson_time.date
      puts "!!!!!Lesson NOT saved, update notices determined by 'determine update state' method...?"
      # flash[:error] = 'Please enter a valid reservation id.'
      render 'edit'
    end
  end

  def admin_confirm_deposit
    @lesson.deposit_status = 'confirmed'
    @lesson.state = 'booked'
    @lesson.save
    redirect_to "/lessons/#{@lesson.id}?state=#{@lesson.state}&admin_deposit_confirmed=true"
  end

  def show
    @lesson = Lesson.find(params[:id])
    # used for QA of email system
    # LessonMailer.track_apply_visits.deliver!
    if @lesson.state == "ready_to_book"
      GoogleAnalyticsApi.new.event('lesson-requests', 'ready-for-deposit')
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.update(state: 'canceled')
    @lesson.update(shopping_cart_id: nil)
    flash[:notice] = 'Your ticket has been canceled.'
    redirect_to view_cart_path
  end

  def admin_reconfirm_state
    @lesson = Lesson.find(params[:id])
    @lesson.state = 'confirmed'
    @lesson.save
    redirect_to @lesson
  end

  def set_instructor
    @lesson = Lesson.find(params[:id])
    @lesson.instructor_id = current_user.instructor.id
    @lesson.state = 'confirmed'
    if @lesson.save
    LessonAction.create!({
      lesson_id: @lesson.id,
      instructor_id: current_user.instructor.id,
      action: "Accept"
      })
    # LessonMailer.send_lesson_confirmation(@lesson).deliver
    @lesson.send_sms_to_requester
    redirect_to @lesson
    else
     redirect_to @lesson, notice: "Error: could not accept lesson. #{@lesson.errors.full_messages}"
    end
  end

  def decline_instructor
    @lesson = Lesson.find(params[:id])
    LessonAction.create!({
      lesson_id: @lesson.id,
      instructor_id: current_user.instructor.id,
      action: "Decline"
      })
    if @lesson.instructor
        @lesson.send_sms_to_admin_1to1_request_failed
        @lesson.update(state: "requested instructor not available")
      elsif @lesson.available_instructors.count >= 1
      @lesson.send_sms_to_instructor
      else
      @lesson.send_sms_to_admin
    end
    flash[:notice] = 'You have declined the request; another instructor has now been notified.'
    # LessonMailer.send_lesson_confirmation(@lesson).deliver
    redirect_to @lesson
  end

  def remove_instructor
    puts "the params are {#{params}"
    @lesson = Lesson.find(params[:id])
    @lesson.instructor = nil
    @lesson.update(state: 'seeking replacement instructor')
    @lesson.send_sms_to_requester
    if @lesson.available_instructors?
      @lesson.send_sms_to_instructor
      else
      @lesson.send_sms_to_admin
    end
    send_instructor_cancellation_emails
    redirect_to @lesson
  end

  def mark_lesson_complete
    puts "the params are {#{params}"
    @lesson = Lesson.find(params[:id])
    @lesson.state = 'finalizing'
    @lesson.save
    redirect_to @lesson
  end

  def confirm_lesson_time
    @lesson = Lesson.find(params[:id])
    if valid_duration_params?
      @lesson.update(lesson_params.merge(state: 'finalizing payment & reviews'))
      @lesson.state = @lesson.valid? ? 'finalizing payment & reviews' : 'confirmed'
      @lesson.send_sms_to_requester
      # LessonMailer.send_payment_email_to_requester(@lesson).deliver
    end
    respond_with @lesson, action: :show
  end

  private

  def valid_duration_params?
     if params[:lesson][:actual_start_time].length == 0  || params[:lesson][:actual_end_time].length == 0
      flash[:alert] = "Please confirm start & end time, as well as lesson duration."
      return false
    else
      session[:lesson] = params[:lesson]
      return true
    end
  end

  def validate_new_lesson_params
    if params[:lesson].nil? ||  params[:lesson] == "" || params[:lesson][:product_name].nil? || params[:lesson][:product_name] == "" || params[:lesson][:activity].nil? ||  params[:lesson][:lesson_time][:date].length < 10
      session[:lesson] = params[:lesson]
      flash[:alert] = "Please first select a lesson type, date, and time."
      redirect_to new_lesson_path
    else
      session[:lesson] = params[:lesson]
    end
  end

  def save_lesson_params_and_redirect
    puts "!!!!! params are below: #{params}"
    puts params[:lesson][:activity]
    puts params[:lesson][:product_name]
    puts params[:lesson][:lesson_time][:date]
    puts params[:lesson][:lesson_time][:slot]
    puts "!!!!!!! end params"
    # validate_new_lesson_params
  end


  def send_cancellation_email_to_instructor
    if @lesson.instructor.present?
      # LessonMailer.send_cancellation_email_to_instructor(@lesson).deliver
    end
  end

  def send_instructor_cancellation_emails
    # LessonMailer.send_lesson_request_to_new_instructors(@lesson, @lesson.instructor).deliver if @lesson.available_instructors?
    # LessonMailer.inform_requester_of_instructor_cancellation(@lesson, @lesson.available_instructors?).deliver
    # LessonMailer.send_cancellation_confirmation(@lesson).deliver
  end

  def send_lesson_update_notice_to_instructor
    return unless @lesson.deposit_status == 'confirmed'
    if @lesson.instructor.present?
      changed_attributes = @lesson.get_changed_attributes(@original_lesson)
      return unless changed_attributes.any?
      return unless current_user.email != "brian@snowschoolers.com"
      # LessonMailer.send_lesson_update_notice_to_instructor(@original_lesson, @lesson, changed_attributes).deliver
    end
  end

  def check_user_permissions
    return unless @lesson.guest_email.nil?
    # FEB7 - disabling permission check to allow non-signed-in users to resume their reservation
    # unless (current_user && current_user == @lesson.requester || (current_user && current_user.instructor && current_user.instructor.status == "Active") || @lesson.requester.nil? || (current_user.nil? && @lesson.requester.email == "brian@snowschoolers.com") || (current_user && (current_user.user_type == "Ski Area Partner" || current_user.user_type == "Granlibakken Employee"))   )
      # puts "!!!!!!! INSUFFICIENT PERMISSIONS"
      # flash[:alert] = "You do not have access to this page."
      # redirect_to root_path
    # end
  end

  def set_admin_skip_validations
    # @lesson = Lesson.new(lesson_params)
    if current_user && (current_user.email == 'brian@snowschoolers.com' || current_user.user_type == 'Granlibakken Employee')
      puts "!!!current user is admin, preparing to set skip_validations boolean to true."
      session[:skip_validations] = true
      @lesson.skip_validations = true
      puts "!!!marking this lesson free of all other validations"
    else
        puts "!!!user is not admin, and so regular lesson checks will proceeed. "
    end
  end


  def determine_update_state
    if @lesson.check_session_capacity == false
        @lesson.state = 'booking-error due to capacity constraint'
    end
    if @lesson.deposit_status == 'confirmed' && @lesson.is_gift_voucher == false
      flash.now[:notice] = "Your lesson deposit has been recorded, but your lesson reservation is incomplete. Please fix the fields below and resubmit."
      @lesson.state = 'booked'
    elsif @lesson.deposit_status == 'confirmed' && @lesson.is_gift_voucher == true
      flash.now[:notice] = "Lesson voucher information has been updated."
      @lesson.state = 'booked_voucher'
    elsif @lesson.students.count >= 1
      @lesson.state = 'ready_to_bookZZZZ'
    else 
      @lesson.state = 'new'
    end
    @lesson.save
    # @state = params[:lesson][:state]
  end

  def set_lesson
      @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:activity, :phone_number, :requested_location, :state, :student_count, :gear, :lift_ticket_status, :objectives, :duration, :ability_level, :start_time, :actual_start_time, :actual_end_time, :actual_duration, :terms_accepted, :deposit_status, :public_feedback_for_student, :private_feedback_for_student, :instructor_id, :focus_area, :requester_id, :guest_email, :how_did_you_hear, :num_days, :lesson_price, :requester_name, :is_gift_voucher, :includes_lift_or_rental_package, :package_info, :gift_recipient_email, :gift_recipient_name, :lesson_cost, :non_lesson_cost, :product_id, :section_id, :product_name, :lodging_guest, :lodging_reservation_id, :zip_code, :drivers_license, :state_code, :city, :street_address, :date, :check_in_status, :promo_code_id,
      students_attributes: [:id, :name, :age_range, :gender, :relationship_to_requester, :lesson_history, :requester_id, :most_recent_experience, :most_recent_level, :other_sports_experience, :experience, :_destroy])
  end

  def lesson_time_params
    params[:lesson].require(:lesson_time).permit(:date, :slot)
  end
end
