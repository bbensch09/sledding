class Lesson < ActiveRecord::Base
  belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'
  belongs_to :instructor
  belongs_to :shopping_cart
  belongs_to :lesson_time
  has_many :students
  has_one :review
  belongs_to :promo_code
  has_many :transactions
  has_many :lesson_actions
  belongs_to :product #, class_name: 'Product', foreign_key: 'product_id'
  belongs_to :section
  accepts_nested_attributes_for :students, reject_if: :all_blank, allow_destroy: true

  validates :requested_location, presence: true
  # validates :phone_number, presence: true, on: :update
  # validates :duration, :start_time, presence: true, on: :update
  # validates :gear, inclusion: { in: [true, false] }, on: :update
  validates :terms_accepted, inclusion: { in: [true], message: 'must accept terms' }, on: :update
  validates :actual_start_time, :actual_end_time, presence: true, if: :just_finalized?
  # validate :requester_must_not_be_instructor, on: :create
  # validate :lesson_time_must_be_valid
  # validates :date, presence: true
  # validate :student_exists, on: :update

  # confirm students are all over the age of 8
  # validate :age_validator, on: :update
  validate :room_reservation_validator, on: :update
  validate :check_session_capacity
  # validate :block_midweek_early_bird_sessions #disabled for winter 2024, can re-enable if desired to block 9am sessions
  validate :block_night_sessions_unless_fri_or_saturday
  validate :check_night_sledding_against_blocked_dates
  validate :check_preseason_against_blocked_dates
  before_save :check_session_capacity
  before_save :confirm_valid_promo_code
  after_update :update_lesson_state_of_siblings


  #Check to ensure an instructor is available before booking
  # validate :instructors_must_be_available, on: :create
  # validate :add_lesson_to_section
  # before_save :add_lesson_to_section
  # before_save :confirm_valid_email, if: :just_created?
  # after_save :confirm_section_valid
  # after_save :check_if_sections_are_full
  before_save :calculate_actual_lesson_duration, if: :just_finalized?

  def this_season?
    return true if self.lesson_time.date.to_s >= '2022-11-01'
  end


  def customer_email
    if self.requester && !self.requester.email.nil?
      return self.requester.email
    elsif self.guest_email
      return self.guest_email
    else
      return "hello+not_found@snowschooler.scom"
    end
  end

  def lesson_siblings
    if self.shopping_cart
      return self.shopping_cart.lessons
    else
      siblings = []
      siblings << self
      return siblings
    end
  end

  def lesson_shopping_cart_total
    if self.lesson_siblings.count <= 1
      return self.price.to_i
    else
      total = 0
      self.lesson_siblings.each do |lesson|
          puts "!!! lesson siblings found in cart. cart item price of #{lesson.price} is being added to total"
          total += lesson.price.to_i
          end
      return total
    end
  end  

  def update_lesson_state_of_siblings
    return true if self.state != "confirmed"
    self.lesson_siblings.each do |l|
      unless l.state == "confirmed"
        l.state = "confirmed"
        l.save!
      end
    end
  end

  def is_sample_booking?
    return false if self.requester_name.nil?
    return true if self.requester_name.include?("John Doe")
  end

  def self.set_dates_for_sample_bookings
    today = LessonTime.find_or_create_by(date:Date.today)
    tomorrow = LessonTime.find_or_create_by(date:Date.tomorrow)
    sample_bookings = Lesson.all.to_a.keep_if{|booking|booking.is_sample_booking?}
    sample_bookings.each do |booking|
      if booking.id.even?
        booking.lesson_time_id = today.id
        puts "!!! set sample booking date to today"
      else
        booking.lesson_time_id = tomorrow.id
        puts "!!! set sample booking date to tomorrow"
      end
      booking.save!
    end
  end

  def self.remove_all_but_two_sample_bookings
    sample_bookings = Lesson.all.to_a.keep_if{|booking|booking.is_sample_booking?}
    sample_bookings[0..-2].each do |booking|
      booking.destroy!
    end
  end

  def confirmation_number
    array=[]
    self.lesson_siblings.each do |l|
      array << l.unique_confirmation_number(l)
    end
    return array.join(", ")
  end

  def unique_confirmation_number(lesson)
      date = lesson.lesson_time.date.to_s.gsub("-","")
      date = date[4..-1]
      case lesson.location.name
        when 'Granlibakken'
          l = 'SLED'
        else
          l = 'XX'
      end
      if lesson.activity == 'lift_ticket'
        l = 'LIFT'
      elsif lesson.activity == 'snowplay'
        l = 'PLAY'
      else
      end
      ticket_count = lesson.students.count.to_s
      id = lesson.id.to_s.rjust(4,"0")
      confirmation_number = l+'-'+id+'-'+date+'-'+ticket_count
  end

  def self.mark_all_confirmed
    Lesson.all.to_a.each do |lesson|
      lesson.state = 'confirmed'
      lesson.save!
    end
  end

  def includes_rentals?
    if self.product_name == '1hr Learn to Ski Package (rental included)'
      return true
    else
      return false
    end
  end

  def section_assignment_status
    if self.section_id.nil?
      return "Unassigned"
    else
      return "Assigned"
    end
  end

  def check_if_sections_are_full
    section = Lesson.last.section
    unless section.has_capacity?
      puts "!!!section is now sold out"
      LessonMailer.notify_admin_section_sold_out(section).deliver
    end
  end

  def email
    if self.requester
      return self.requester.email
    elsif self.guest_email
      return self.guest_email
    else
      "N/A"
    end
  end

  def name
    if self.requester_name
      return self.requester_name
    elsif self.guest_email
      return self.guest_email
    else
      "N/A"
    end
  end

  def self.seed_lessons(date,number)
    LessonTime.create!({
        date: date,
        slot: ['Early Bird (9-10am)', 'Half-day Morning (10am-1pm)', 'Half-day Afternoon (1pm-4pm)','Full-day (10am-4pm)', 'Mountain Rangers All-day', 'Snow Rangers All-day'].sample
        })
    number.times do
      puts "!!! - first creating new student user"
      User.create!({
          email: Faker::Internet.email,
          password: 'homewood_temp_2017',
          user_type: "Student",
          name: Faker::Name.name
          })
      puts "!!! - user created; begin creating lesson"
      Lesson.create!({
          requester_id: User.last.id,
          deposit_status: "confirmed",
          # lesson_time_id: LessonTime.all.sample.id,
          lesson_time_id: LessonTime.last.id,
          activity: ["Ski","Snowboard"].sample,
          requested_location: "8",
          requester_name: User.last.name,
          phone_number: "530-430-7669",
          gear: [true,false].sample,
          lift_ticket_status: [true,false].sample,
          objectives: "I want to learn how to become the best skier on the mountain!",
          state: "booked",
          product_id: [1,4,10,14,14,14,14,15,15,15,15].sample,
          terms_accepted: true
        })
      puts "!!! - lesson created, creating students for lesson"
      last_lesson_product_age_type = Lesson.last.product.age_type
      if last_lesson_product_age_type == "Child"
        sample_age = (4..12).to_a.sample
      elsif last_lesson_product_age_type == "Adult"
        sample_age = (12..50).to_a.sample
      else
        sample_age = (4..50).to_a.sample
      end
      Student.create!({
          lesson_id: Lesson.last.id,
          name: "Student Jon",
          age_range: sample_age,
          gender: "Male",
          relationship_to_requester: "I am the student",
          most_recent_level: ["Level 1 - first-time ever, no previous experience.",
              "Level 2 - can safely stop on beginner green circle terrain.",
              "Level 3 - can makes wedge turns (heel-side turns for snowboarding) in both directions on beginner terrain.",
              "Level 4 - can link turns with moderate speed on all beginner terrain."].sample
        })
      puts "!!! - seed lesson created"
    end
  end

  def self.bookings_for_date(date)
    lessons = Lesson.all.to_a.keep_if{|lesson| lesson.date == date}
    return lessons.count
  end

  def date
    unless lesson_time.nil?
      lesson_time.date
    end
  end

  def self.set_all_lessons_to_Homewood
    Lesson.all.to_a.each do |lesson|
      if lesson.requested_location != 8
        lesson.requested_location = 8
        lesson.save
      end
    end
  end

  def slot
    unless lesson_time.nil?
      lesson_time.slot
    end
  end

  def product
    if self.product_id.nil?
      Product.where(location_id:self.location.id, name:self.lesson_time.slot,calendar_period:self.lookup_calendar_period(self.lesson_time.date)).first
    else
      Product.where(id:self.product_id).first
    end
  end

  def tip
    if self.transactions.any?
    tip_amount = (self.transactions.last.final_amount - self.transactions.last.base_amount)
    tip_amount = ((tip_amount*100).to_i).to_f/100
    else
      return "N/A"
    end
  end

  def final_charge
    self.transactions.last.final_amount - self.price.to_i
  end

  def post_stripe_tip
    if tip <= 0
      return 0
    else
      return (self.tip * 0.971) - 0.30
    end
  end

  def lift_ticket_status?
    return true if self.lift_ticket_status == "Yes, I have one."
  end

  def adjusted_price
    if self.id == 319
      return 469
    end
    return self.price if actual_duration <= self.product.length.to_i
    delta = actual_duration - self.product.length.to_i
    if delta == 3 && self.product.length.to_i == 1
      upsell_type = "extend_early_bird_to_half"
    elsif delta == 3 && self.product.length.to_i == 3
      upsell_type = "extend_half_day_to_full"
    elsif delta == 6 && self.product.length.to_i == 1
      upsell_type = "extend_early_bird_to_full"
    else
      puts "!!!!!!ERROR"
    end
    puts "!!!!!! length of lesson extension = #{delta}"
    case upsell_type
    when "extend_early_bird_to_half"
      return Product.where(length:3,calendar_period:self.location.calendar_status).first.price
    when "extend_half_day_to_full"
      return Product.where(length:6,calendar_period:self.location.calendar_status).first.price
    when "extend_early_bird_to_full"
      return Product.where(length:6,calendar_period:self.location.calendar_status).first.price
    else
      return self.price
    end
  end

  def location
    Location.find(self.requested_location.to_i)
  end

  def active?
    active_states = ['new', 'booked', 'confirmed','pending instructor','gift_voucher_reserved','pending requester','']
    #removed 'confirmed' from active states to avoid sending duplicate SMS messages.
    active_states.include?(state)
  end

  def active_today?
    active_states = ['confirmed','seeking replacement instructor','pending instructor', 'pending requester','Lesson Complete','finalizing payment & reviews','waiting for review','finalizing','ready_to_book']
    #removed 'confirmed' from active states to avoid sending duplicate SMS messages.
    return true if self.date == Date.today && active_states.include?(state)
  end

  def paid?
    active_states = ['booked','confirmed','Lesson Complete','finalizing payment & reviews','waiting for review','finalizing']
    return true if active_states.include?(state) #&& self.date > Date.today #mother fucker!!!
  end

  def upcoming?
    active_states = ['new','booked','confirmed','seeking replacement instructor','pending instructor', 'pending requester','Lesson Complete','finalizing payment & reviews','waiting for review','finalizing','ready_to_book']
    return true if active_states.include?(state) && self.date > Date.today
  end

  def confirmable?
    confirmable_states = ['booked', 'pending instructor', 'pending requester','seeking replacement instructor']
    confirmable_states.include?(state) #&& self.available_instructors.any?
  end

  def is_gift_voucher?
    if self.is_gift_voucher == true
      return true
    else
      return false
    end
  end

  def includes_rental?
    self.product_name == '1hr Learn to Ski Package (rental included)' ? 'Yes' : 'No'
  end

  def confirmed?
    confirmed_states = ['confirmed', 'pending instructor', 'pending requester']
    confirmed_states.include?(state)
  end

  def completable?
    self.state == 'confirmed'
  end

  def new?
    state == 'new'
  end

  def canceled?
    state == 'canceled'
  end

  def pending_instructor?
    state == 'pending instructor'
  end

  def pending_requester?
    state == 'pending requester'
  end

  def finalizing?
    state == 'finalizing'
  end

  def waiting_for_payment?
    state == 'finalizing payment & reviews'
  end

  def booked?
    eligible_states = ['booked','confirmed']
    eligible_states.include?(state)

  end

  def ready_to_book?
    state == 'ready_to_book'
  end

  def waiting_for_review?
    state == 'Lesson complete, waiting for review.'
  end

  def completed?
    active_states = ['finalizing','finalizing payment & reviews','Payment complete, waiting for review.','Lesson Complete']
    #removed 'confirmed' from active states to avoid sending duplicate SMS messages.
    active_states.include?(state)
  end

  def payment_complete?
    state == 'Payment complete, waiting for review.' || state == 'Lesson Complete'
  end

  def referral_source
    case self.how_did_you_hear.to_i
    when 1
      return 'From a friend'
    when 2
      return 'Facebook'
    when 3
      return 'Google'
    when 4
      return 'From a postcard'
    when 5
      return 'From someone at Homewood'
    when 6
      return 'Tahoe Daves'
    when 7
      return 'Ski Butlers'
    when 8
      return 'Yelp'
    when 100
      return 'Other'
    end
  end

  def instructor_accepted?
    LessonAction.where(action:"Accept", lesson_id: self.id).any?
  end

  def self.visible_to_instructor?(instructor)
      lessons = []
      assigned_to_instructor = Lesson.where(instructor_id:instructor.id)
      available_to_instructor = Lesson.all.to_a.keep_if {|lesson| (lesson.confirmable? && lesson.instructor_id.nil? )}
      lessons = assigned_to_instructor + available_to_instructor
  end

  def declined_instructors
    decline_actions = LessonAction.where(action:"Decline", lesson_id: self.id)
    declined_instructors = []
    decline_actions.each do |action|
      declined_instructors << Instructor.find(action.instructor_id)
    end
    declined_instructors
  end


  def calculate_actual_lesson_duration
    start_time = Time.parse(actual_start_time)
    end_time = Time.parse(actual_end_time)
    self.actual_duration = (end_time - start_time)/3600
  end

  def just_finalized?
    waiting_for_payment?
  end

  def just_created?
    return true if Lesson.count == 0 || self.id == Lesson.last.id
  end

  def lookup_calendar_period(date)
    date = date.to_s
    if HOLIDAYS.include?(date)
      return 'Holiday'
    elsif WEEKENDS.include?(date)
      return 'Holiday'
    elsif NON_HOLIDAYS.include?(date)
      return 'Regular'
    else
      return 'Regular'
    end
  end

  def self.open_lesson_requests
    Lesson.where(state:'booked')
  end

  def self.open_booked_revenue
    lessons = Lesson.open_lesson_requests
    total = 0
    lessons.each do |lesson|
      total += lesson.price.to_i
    end
    return total
  end

  def participants_3_and_under
    count = 0
    self.students.each do |participant|
      if participant.age_range.to_i <= 3
        count +=1
      end
    end
    return count
  end

  def count_participants_under12
    count = 0
    self.students.each do |participant|
      if participant.age_range.to_i <= 12
        count +=1
      end
    end
    return count
  end

  def product_name
    if self.activity == 'sledding'
      return "Sledding Ticket(s) - #{self.slot}"
    elsif self.activity == 'lift_ticket'      
      return "Ski Hill - #{self.slot}"
    else 'Snowplay Tickets'
    end
  end

  def price
      calendar_period = self.lookup_calendar_period(self.lesson_time.date)
      puts "!!!!lookup calendar period status, it is: #{calendar_period}"
      product = Product.where(location_id:24,calendar_period:calendar_period).first
    if product.nil?
      return "Lesson price or product not found" #99 #default lesson price - temporary
    elsif self.lesson_price
      price = self.lesson_price
    elsif self.activity == "lift_ticket"
      children = self.count_participants_under12
      adults = self.students.count - children
      if calendar_period == 'Holiday'
          price = (children * 35) + (adults * 45)
        else
          price = (children * 30) + (adults * 40)
      end
    elsif self.activity == "snowplay"
      if calendar_period == 'Holiday'
          price = self.students.count * 15
        else
          price = self.students.count * 10
      end
    elsif self.package_info == "Night Sledding"
    # elsif self.package_info == "NYE Special Sled Ticket"
        price = 35 * [1,(self.students.count - self.participants_3_and_under)].max
    elsif self.package_info == "Afterschool Special"
    # elsif self.package_info == "NYE Special Sled Ticket"
        price = self.students.count * 12.50
    elsif self.date < '2021-12-15'.to_date
      # special price for Thanksgiving 2021
      price = 15 * [1,(self.students.count - self.participants_3_and_under)].max
    else
      price = product.price * [1,(self.students.count - self.participants_3_and_under)].max
    end
    if self.promo_code
      case self.promo_code.discount_type
      when 'cash'
        # puts "!!!discount of #{self.promo_code.discount} is applied to total price."
        price = (price.to_f - self.promo_code.discount.to_f)
      when 'percent'
        # puts "!!!discount percentage of of #{self.promo_code.discount} is applied to total price."
        price = (price.to_f * (1-self.promo_code.discount.to_f/100))
      end
    end
    if self.lodging_guest == true && self.lodging_reservation_id && self.lodging_reservation_id.length == 6
      price = price *0.5
    end
    return price.to_s
  end

  # FLAG for removal -- likely unnecessary
  def original_price
    return self.price unless self.promo_code
    case self.promo_code.discount_type
      when 'cash'
        return original_price = self.price.to_f + self.promo_code.discount.to_f
      when 'percent'
        return original_price = self.price.to_f / (1-self.promo_code.discount.to_f/100)
      end
  end


  def price_per_student
    return (self.price.to_f) / (self.students.count)
  end

  def package_cost
    package_price = 0
    puts "!!!calculating package cost"
    p1 = [self.additional_students_with_gear * self.cost_per_additional_student_with_gear,0].max
    p2 = [self.additional_students_without_gear * self.cost_per_additional_student_without_gear,0].max
    return p1 + p2
    return package_price
  end

  def cost_per_additional_student_with_gear
    return 65
  end

  def cost_per_additional_student_without_gear
    return 40
  end

  def additional_students_with_gear
      self.location.id == 24 ? count = -1 : count = 0
      self.students.each do |student|
        if self.gear == false
          count += 1
        end
      end
      count
  end

  def additional_students_without_gear
      self.location.id == 24 ? count = -1 : count = 0
      self.students.each do |student|
        unless self.gear == false
          count += 1
        end
      end
      return [count,0].max
  end

  def visible_lesson_cost
    if self.lesson_cost.nil?
      return self.price
    else
      return self.lesson_cost
    end
  end

  def get_changed_attributes(original_lesson)
    lesson_changes = self.previous_changes
    lesson_time_changes = self.lesson_time.changes
    changed_attributes = lesson_changes.merge(lesson_time_changes)
    changed_attributes.reject { |attribute, change| ['updated_at', 'id', 'state', 'lesson_time_id'].include?(attribute) }
  end

  def kids_lesson?
    self.students.each do |student|
      return true if student.age_range == 'Under 10' || student.age_range == '11-17'
    end
    return false
  end

  def seniors_lesson?
    self.students.each do |student|
      return true if student.age_range == '51 and up'
    end
    return false
  end

  def level
    return false if self.students.nil?
    student_levels = []
    self.students.each do |student|
      #REFACTOR ALERT extract the 7th character from student experience level, which yields the level#, such as in 'Level 2 - wedge turns...'
      student_levels << student.most_recent_level[6].to_i
    end
    return student_levels.max
  end

  def athlete
    if self.activity == "Ski"
      return "skier"
    else
      return "snowboarder"
    end
  end

  def sport_id
    if self.activity == "Ski"
      Sport.where(name:"Ski Instructor").first.id
    else
      Sport.where(name:"Snowboard Instructor").first.id
    end
  end

  def available_sections
    sections = Section.where(sport_id:self.sport_id,date:self.lesson_time.date,slot:self.lesson_time.slot)
    sections = sections.select{|section| section.has_capacity?}
  end

  def add_lesson_to_section
    return true if self.section_id && self.sport_id == self.section.sport_id && self.date == self.section.date
    existing_sections = self.available_sections
      if self.available_sections.count == 0
      puts "!!!!!!!! The requested time slot is full!!!!!"
      self.state = 'This section is unfortunately full, please choose another time slot.'
      errors.add(:lesson, "There is unfortunately no more room in this lesson, please review the available times below and choose another slot.")
      return false
      end
      puts "!!!!section available is #{available_sections.first }"
      self.section_id = available_sections.first.id
      self.state = "new"
  end

  def confirm_section_valid
    if self.section.nil?
      if self.available_sections.count == 0
          errors.add(:lesson, "There is unfortunately no more room in this lesson, please review the available times below and choose another slot.")
          return false
      end
      self.section_id = self.available_sections.first.id
      self.save
    elsif self.section.remaining_capacity <= 0
      puts "!!!!warning, at capcity"
    else self.section.remaining_capacity >= 1
      return true
    end
  end

  def confirm_valid_email
    if self.guest_email
      puts "!!! user guest emails is: #{self.guest_email.downcase}"
      if self.requester_id
        return true
      elsif User.find_by_email(self.guest_email.downcase)
          self.requester_id = User.find_by_email(self.guest_email.downcase).id
          puts "!!!! user is checking out as guest; found matching email from previous entry"
          return true
      elsif self.guest_email.include?("@")
          User.create!({
          email: self.guest_email,
          password: 'sstemp2017',
          user_type: "Student",
          name: "#{self.guest_email}"
          })
         self.requester_id = User.last.id
         return true
         puts "!!!! user is checking out as guest; create a temp email for them that must be confirmed"
       else
        errors.add(:lesson, "Please enter a valid email, or sign-into your account.")
        return false
      end
    end
  end

  def self.assign_all_instructors_to_sections
    unassigned_sections = Section.all.select{|section| section.instructor_id.nil?}
    unassigned_sections.each do |section|
      section.instructor_id = section.available_instructors.first.id
      section.save!
    end
    unassigned_lessons = Lesson.where(instructor_id:nil)
    puts "!!!!!!!!! there are #{unassigned_lessons.count} unassigned lessons"
    unassigned_lessons.each do |lesson|
      if lesson.section.nil?
        lesson.section_id = lesson.available_sections.first ? lesson.available_sections.first.id : Section.first.id
        lesson.instructor_id = lesson.section.instructor_id
        lesson.save
      end
    end
  end

  def available_instructors
    if self.instructor_id
        if  Lesson.instructors_with_calendar_blocks(self.lesson_time).include?(self.instructor)
          return []
        else
          return [self.instructor]
        end
    else
    resort_instructors = self.location.instructors
    puts "!!!!!!! - Step #1 Filtered for location, found #{resort_instructors.count} instructors."
    active_resort_instructors = resort_instructors.where(status:'Active')
    puts "!!!!!!! - Step #2 Filtered for active status, found #{active_resort_instructors.count} instructors."
    if self.activity == 'Ski' && self.level
      active_resort_instructors = active_resort_instructors.to_a.keep_if {|instructor| (instructor.ski_levels.any? && instructor.ski_levels.max.value >= self.level) }
    end
    if self.activity == 'Snowboard' && self.level
      active_resort_instructors = active_resort_instructors.to_a.keep_if {|instructor| (instructor.snowboard_levels.any? && instructor.snowboard_levels.max.value >= self.level )}
    end
    puts "!!!!!!! - Step #3 Filtered for level, found #{active_resort_instructors.count} instructors."
    if kids_lesson?
      active_resort_instructors = active_resort_instructors.to_a.keep_if {|instructor| instructor.kids_eligibility == true }
      puts "!!!!!!! - Step #3b Filtered for kids specialist, now have #{active_resort_instructors.count} instructors."
    end
    if seniors_lesson?
      active_resort_instructors = active_resort_instructors.to_a.keep_if {|instructor| instructor.seniors_eligibility == true }
      puts "!!!!!!! - Step #3c Filtered for seniors specialist, now have #{active_resort_instructors.count} instructors."
    end
    if self.activity == 'Ski'
        active_resort_instructors = active_resort_instructors.to_a.keep_if {|instructor| instructor.ski_instructor? }
      elsif self.activity == "Snowboard"
        active_resort_instructors = active_resort_instructors.to_a.keep_if {|instructor| instructor.snowboard_instructor? }
      elsif self.activity == "Telemark"
        active_resort_instructors = active_resort_instructors.to_a.keep_if {|instructor| instructor.telemark_instructor? }
    end
    puts "!!!!!!! - Step 3d Filtere for correct sport."
    already_booked_instructors = Lesson.booked_instructors(lesson_time)
    busy_instructors = Lesson.instructors_with_calendar_blocks(lesson_time)
    declined_instructors = []
    declined_actions = LessonAction.where(lesson_id: self.id, action:"Decline")
    declined_actions.each do |action|
      declined_instructors << Instructor.find(action.instructor_id)
    end
    puts "!!!!!!! - Step #4b - eliminating #{already_booked_instructors.count} that are already booked."
    puts "!!!!!!! - Step #4c - eliminating #{declined_instructors.count} that have declined."
    puts "!!!!!!! - Step #4d - eliminating #{busy_instructors.count} that are busy."
    available_instructors = active_resort_instructors - already_booked_instructors - declined_instructors - busy_instructors
    puts "!!!!!!! - Step #5 after all filters, found #{available_instructors.count} instructors."
    available_instructors = self.rank_instructors(available_instructors)
    return available_instructors
    end
  end

  def rank_instructors(available_instructors)
    puts "!!!!!!!ranking instructors now"
    if kids_lesson?
      available_instructors.sort! {|a,b| b.kids_score <=> a.kids_score }
      elsif seniors_lesson?
      available_instructors.sort! {|a,b| b.seniors_score <=> a.seniors_score }
      else
      available_instructors.sort! {|a,b| b.overall_score <=> a.overall_score }
    end
    return available_instructors
  end

  def available_instructors?
    return true
    available_instructors.any?
  end

  def self.find_lesson_times_by_requester(user)
    self.where('requester_id = ?', user.id).map { |lesson| lesson.lesson_time }
  end

  def self.instructors_with_calendar_blocks(lesson_time)
    if lesson_time.slot == 'Full-day (10am-4pm)'
      calendar_blocks = self.find_all_calendar_blocks_in_day(lesson_time)
    else
      calendar_blocks = self.find_calendar_blocks(lesson_time)
    end
    blocked_instructors =[]
    calendar_blocks.each do |block|
      blocked_instructors << Instructor.find(block.instructor_id)
    end
    return blocked_instructors
  end

  def self.find_calendar_blocks(lesson_time)
    same_slot_blocks = CalendarBlock.where(lesson_time_id:lesson_time.id, status:'Block this time slot')
    overlapping_full_day_blocks = self.find_full_day_blocks(lesson_time)
    return same_slot_blocks + overlapping_full_day_blocks
  end

  def self.find_full_day_blocks(lesson_time)
    full_day_block_time = LessonTime.find_by_date_and_slot(lesson_time.date,'Full-day (10am-4pm)')
    return [] if full_day_block_time.nil?
    full_day_blocks = []
    blocks_on_same_day = CalendarBlock.where(lesson_time_id:full_day_block_time.id, status:'Block this time slot')
      blocks_on_same_day.each do |block|
        full_day_blocks << block
      end
    return full_day_blocks
  end

  def self.find_all_calendar_blocks_in_day(lesson_time)
    matching_lesson_times = LessonTime.where(date:lesson_time.date)
    return [] if matching_lesson_times.nil?
    calendar_blocks = []
    matching_lesson_times.each do |lt|
      blocks_at_lt = CalendarBlock.where(lesson_time_id:lt.id)
      blocks_at_lt.each do |block|
        calendar_blocks << block
      end
    end
    return calendar_blocks
  end

  def self.booked_instructors(lesson_time)
    # puts "checking for booked instructors on #{lesson_time.date} during the #{lesson_time.slot} slot"
    if lesson_time.slot == 'Full-day (10am-4pm)'
      booked_lessons = self.find_all_booked_lessons_in_day(lesson_time)
    else
      booked_lessons = self.find_booked_lessons(lesson_time)
    end
    # puts "There is/are #{booked_lessons.count} lesson(s) already booked at this time."
    booked_instructors = []
    booked_lessons.each do |lesson|
      booked_instructors << lesson.instructor
    end
    return booked_instructors
  end

  def self.find_booked_lessons(lesson_time)
    lessons_in_same_slot = Lesson.where('lesson_time_id = ?', lesson_time.id)
    overlapping_full_day_lessons = self.find_full_day_lessons(lesson_time)
    return lessons_in_same_slot + overlapping_full_day_lessons
  end

  def self.find_full_day_lessons(full_day_lesson_time)
    return [] unless full_day_lesson_time = LessonTime.find_by_date_and_slot(full_day_lesson_time.date,'Full-day (10am-4pm)')
    booked_lessons = []
    lessons_on_same_day = Lesson.where("lesson_time_id=? AND instructor_id is not null",full_day_lesson_time.id)
      lessons_on_same_day.each do |lesson|
        booked_lessons << lesson
        # puts "added a booked lesson to the booked_lesson set"
      end
    puts "After searching for other full-day lessons on this date, we found a total of #{booked_lessons.count} other lessons on this date."
    return booked_lessons
  end

  def self.find_all_booked_lessons_in_day(full_day_lesson_time)
    matching_lesson_times = LessonTime.where("date=?",full_day_lesson_time.date)
    # puts "------there are #{matching_lesson_times.count} matched lesson times on this date."
    booked_lessons = []
    matching_lesson_times.each do |lt|
      lessons_at_lt = Lesson.where("lesson_time_id=? AND instructor_id is not null",lt.id)
      lessons_at_lt.each do |lesson|
        booked_lessons << lesson
      end
    end
    # puts "After searching through the matching lesson times on this date, the booked lesson count on this day is now: #{booked_lessons.count}"
    return booked_lessons
  end

  def send_sms_reminder_to_instructor_complete_lessons
      # ENV variable to toggle Twilio on/off during development
      return if ENV['twilio_status'] == "inactive"
      account_sid = ENV['TWILIO_SID']
      auth_token = ENV['TWILIO_AUTH']
      snow_schoolers_twilio_number = ENV['TWILIO_NUMBER']
      recipient = self.instructor.phone_number
      body = "Hope you had a great Granlibakken lesson. Please confirm the start/end times and complete feedback for your student by visiting the lesson page at #{ENV['HOST_DOMAIN']}/lessons/#{self.id} to confirm."
      @client = Twilio::REST::Client.new account_sid, auth_token
          @client.account.messages.create({
          :to => recipient,
          :from => "#{snow_schoolers_twilio_number}",
          :body => body
      })
      # send_reminder_sms
      # LessonMailer.notify_admin_sms_logs(self,recipient,body).deliver
  end

  def send_sms_to_instructor
      # ENV variable to toggle Twilio on/off during development
      return if ENV['twilio_status'] == "inactive"
      account_sid = ENV['TWILIO_SID']
      auth_token = ENV['TWILIO_AUTH']
      snow_schoolers_twilio_number = ENV['TWILIO_NUMBER']
      recipient = self.available_instructors.any? ? self.available_instructors.first.phone_number : "4083152900"
      case self.state
        when 'new'
          body = "A lesson booking was begun and not finished. Please contact an admin or email tickets@granlibakken.com if you intended to complete the lesson booking."
        when 'booked'
          body = "#{self.available_instructors.first.first_name}, You have a new lesson request from #{self.requester.name} at #{self.lesson_time.slot} on #{self.lesson_time.date.strftime("%b %d")} at #{self.location.name}. They are a level #{self.level.to_s} #{self.athlete}. Are you available? Please visit #{ENV['HOST_DOMAIN']}/lessons/#{self.id} to confirm."
        when 'seeking replacement instructor'
          body = "We need your help! Another instructor unfortunately had to cancel. Are you available to teach #{self.requester.name} on #{self.lesson_time.date.strftime("%b %d")} at #{self.location.name} at #{self.lesson_time.slot}? Please visit #{ENV['HOST_DOMAIN']}/lessons/#{self.id} to confirm."
        when 'pending instructor'
          body =  "#{self.available_instructors.first.first_name}, There has been a change in your previously confirmed lesson request. #{self.requester.name} would now like their lesson to be at #{self.lesson_time.slot} on #{self.lesson_time.date.strftime("%b %d")} at #{self.location.name}. Are you still available? Please visit #{ENV['HOST_DOMAIN']}/lessons/#{self.id} to confirm."
        when 'Payment complete, waiting for review.'
          if self.transactions.last.tip_amount == 0.0009
            body = "#{self.requester.name} has completed their lesson review and reported that they gave you a cash tip. Great work!"
          elsif self.transactions.last.tip_amount == 0
            body = "Hope you had a great lesson with #{self.requester.name}. They have now completed their lesson review, which you should receive an email notification about shortly."
          else
            body = "#{self.requester.name} has completed payment for their lesson and you've received a tip of $#{self.post_stripe_tip.round(2)}. Great work!"
          end
      end
      @client = Twilio::REST::Client.new account_sid, auth_token
          @client.account.messages.create({
          :to => recipient,
          :from => "#{snow_schoolers_twilio_number}",
          :body => body
      })
      send_reminder_sms
      # puts "!!!!Body: #{body}"
      puts "!!!!! - reminder SMS has been scheduled"
      # LessonMailer.notify_admin_sms_logs(self,recipient,body).deliver
  end

  def send_reminder_sms
    # ENV variable to toggle Twilio on/off during development
    return if ENV['twilio_status'] == "inactive"
    return if self.state == 'confirmed' || (Time.now - LessonAction.last.created_at) < 20
    account_sid = ENV['TWILIO_SID']
    auth_token = ENV['TWILIO_AUTH']
    snow_schoolers_twilio_number = ENV['TWILIO_NUMBER']
    recipient = self.available_instructors.any? ? self.available_instructors.first.phone_number : "4083152900"
    body = "#{self.available_instructors.first.first_name}, it has been over 5 minutes and you have not accepted or declined this request. We are now making this lesson available to other instructors. You may still visit #{ENV['HOST_DOMAIN']}/lessons/#{self.id} to confirm the lesson."
    @client = Twilio::REST::Client.new account_sid, auth_token
          @client.account.messages.create({
          :to => recipient,
          :from => "#{snow_schoolers_twilio_number}",
          :body => body
      })
      puts "!!!!! - reminder SMS has been sent"
      send_sms_to_all_other_instructors
      # LessonMailer.notify_admin_sms_logs(self,recipient,body).deliver
  end
  handle_asynchronously :send_reminder_sms, :run_at => Proc.new {300.seconds.from_now }

  def send_sms_to_all_other_instructors
    # ENV variable to toggle Twilio on/off during development
    return if ENV['twilio_status'] == "inactive"
    recipients = self.available_instructors
    if recipients.count < 2
      @client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH']
          @client.account.messages.create({
          :to => "408-315-2900",
          :from => ENV['TWILIO_NUMBER'],
          :body => "ALERT - #{self.available_instructors.first.name} is the only instructor available and they have not responded after 10 minutes. No other instructors are available to teach #{self.requester.name} at #{self.lesson_time.slot} on #{self.lesson_time.date} at #{self.location.name}."
      })
    end
    # identify recipients to be notified as all available instructors except for the first instructor, who has been not responsive
    recipients[1..-1].each do |instructor|
      account_sid = ENV['TWILIO_SID']
      auth_token = ENV['TWILIO_AUTH']
      snow_schoolers_twilio_number = ENV['TWILIO_NUMBER']
      body = "#{instructor.first_name}, we have a customer who is eager to find an instructor. #{self.requester.name} wants a lesson at #{self.lesson_time.slot} on #{self.lesson_time.date.strftime("%b %d")} at #{self.location.name}. Are you available? The lesson is now available to the first instructor that claims it by visiting #{ENV['HOST_DOMAIN']}/lessons/#{self.id} and accepting the request."
      @client = Twilio::REST::Client.new account_sid, auth_token
            @client.account.messages.create({
            :to => instructor.phone_number,
            :from => "#{snow_schoolers_twilio_number}",
            :body => body
        })
    end
    # LessonMailer.notify_admin_sms_logs(self,recipient,body).deliver
  end
  # handle_asynchronously :send_sms_to_all_other_instructors, :run_at => Proc.new {5.seconds.from_now }

  def send_manual_sms_request_to_instructor(instructor)
      # ENV variable to toggle Twilio on/off during development
      return if ENV['twilio_status'] == "inactive"
      account_sid = ENV['TWILIO_SID']
      auth_token = ENV['TWILIO_AUTH']
      snow_schoolers_twilio_number = ENV['TWILIO_NUMBER']
      recipient = instructor.phone_number
      body = "Hi #{instructor.first_name}, we have a customer who is eager to find a #{self.activity} instructor. #{self.requester.name} wants a lesson at #{self.lesson_time.slot} on #{self.lesson_time.date.strftime("%b %d")} at #{self.location.name}. Are you available? The lesson is now available to the first instructor that claims it by visiting #{ENV['HOST_DOMAIN']}/lessons/#{self.id} and accepting the request."
      @client = Twilio::REST::Client.new account_sid, auth_token
          @client.account.messages.create({
          :to => recipient,
          :from => "#{snow_schoolers_twilio_number}",
          :body => body
      })
      # LessonMailer.notify_admin_sms_logs(self,recipient,body).deliver
  end

  def send_sms_to_requester
      # ENV variable to toggle Twilio on/off during development
      return if ENV['twilio_status'] == "inactive"
      account_sid = ENV['TWILIO_SID']
      auth_token = ENV['TWILIO_AUTH']
      snow_schoolers_twilio_number = ENV['TWILIO_NUMBER']
      recipient = self.phone_number.gsub(/[^0-9a-z ]/i,"")
      case self.state
        when 'confirmed'
        body = "Congrats! Your Granlibakken lesson has been confirmed. #{self.instructor.name} will be your instructor at #{self.location.name} on #{self.lesson_time.date.strftime("%b %d")} at #{self.lesson_time.slot}. Please check your email for more details about meeting location & to review your pre-lesson checklist."
        when 'seeking replacement instructor'
        body = "Bad news! Your instructor has unfortunately had to cancel your lesson. Don't worry, we are finding you a new instructor right now."
        when 'finalizing payment & reviews'
        body = "We hope you had a great lesson with #{self.instructor.name}! You may now complete the lesson experience online and leave a quick review for #{self.instructor.first_name} by visiting #{ENV['HOST_DOMAIN']}/lessons/#{self.id}. Thanks for using Granlibakken!"
      end
      if recipient.length == 10 || recipient.length == 11
        @client = Twilio::REST::Client.new account_sid, auth_token
            @client.account.messages.create({
            :to => recipient,
            :from => "#{snow_schoolers_twilio_number}",
            :body => body
        })
          LessonMailer.notify_admin_sms_logs(self,recipient,body).deliver
          else
            puts "!!!! error - could not send SMS via Twilio"
            # LessonMailer.send_admin_notify_invalid_phone_number(self).deliver
        end
  end

  def send_sms_to_admin
      @client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH']
          @client.account.messages.create({
          :to => "408-315-2900",
          :from => ENV['TWILIO_NUMBER'],
          :body => "ALERT - no instructors are available to teach #{self.requester.name} at #{self.lesson_time.slot} on #{self.lesson_time.date} at #{self.location.name}. The last person to decline was #{Instructor.find(LessonAction.last.instructor_id).username}."
      })
      # LessonMailer.notify_admin_sms_logs(self,body).deliver
  end

  def send_sms_to_admin_1to1_request_failed
      @client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH']
          @client.account.messages.create({
          :to => "408-315-2900",
          :from => ENV['TWILIO_NUMBER'],
          :body => "ALERT - A private 1:1 request was made and declined. #{self.requester.name} had requested #{self.instructor.name} but they are unavailable at #{self.lesson_time.slot} on #{self.lesson_time.date} at #{self.location.name}."
      })
      # LessonMailer.notify_admin_sms_logs(self,recipient,body).deliver
  end

  def self.to_csv(options = {})
    desired_columns = %w{
      id date created_at confirmation_number requester_name phone_number guest_email price
    }
    CSV.generate(headers: true) do |csv|
      csv << desired_columns
      all.each do |lesson|
        csv << lesson.attributes.values_at(*desired_columns)
      end
    end
  end

  def check_session_capacity
    #Admin should always allowed to confirm/book tickets;
    return true if self.skip_validations == true #|| session[:skip_validations] == true 
    puts "lesson id, lesson_time_id, and skip_validations is #{self.id}, #{self.lesson_time_id}, and #{self.skip_validations}"
    if self.activity == 'lift_ticket'
      if (current_day_lift_tickets_sold + self.students.count) <= SKIHILL_CAPACITY
        return current_day_lift_tickets_sold
      else
        puts "!!! reservation rejected due to lift tickets being sold out"
        errors.add(:lesson,"Unfortunately there are no more lift tickets available. Please try another day. To see what days are not sold out, please contact us at tickets@granlibakken.com or call us at 530-583-4242.")
        return false
      end
    elsif self.activity == 'sledding'
      if (current_session_tickets_sold + self.students.count) <= SLEDHILL_CAPACITY
        return current_session_tickets_sold
      else
        puts "!!! reservation rejected due to sledding session capacity being sold out"
        errors.add(:lesson,"Unfortunately this sledding session is sold out. Please try another time slot. To see which sessions still have capacity, please contact us at tickets@granlibakken.com or call us at 530-583-4242.")
        return false
      end
    elsif self.activity == 'snowplay'
      return true
    else
    end

  end

  def current_session_tickets_sold
    same_session_entries = Lesson.where(lesson_time_id:self.lesson_time_id).to_a
    puts "!!! there are #{same_session_entries.count} bookings found in same_session_entries"
    same_session_paid_bookings = same_session_entries.keep_if{|l| l.paid?}
    puts "!!! there are #{same_session_paid_bookings.count} bookings found in same_session_paid_bookings"
    tickets = 0
    same_session_paid_bookings.each do |booking|
      tickets+= booking.students.count
      puts "!!! added #{booking.students.count} tickets to running total"
    end
    puts "!!! There are #{tickets} other ticets already sold"
    return tickets
  end

  def current_day_lift_tickets_sold
    all_tix = Lesson.where(activity:'lift_ticket').to_a
    same_day_paid_bookings = all_tix.keep_if{|l| l.paid? && l.date == self.date}
    puts "!!! there are #{same_day_paid_bookings.count} bookings found in same_session_paid_bookings"
    tickets = 0
    same_day_paid_bookings.each do |booking|
      tickets+= booking.students.count
      puts "!!! added #{booking.students.count} tickets to running total"
    end
    puts "!!! There are #{tickets} other ticets already sold"
    return tickets
  end

  def session_capacity_remaining
    return SLEDHILL_CAPACITY - current_session_tickets_sold
  end

  def skihill_capacity_remaining
    return SKIHILL_CAPACITY - current_day_lift_tickets_sold
  end


  private

  def instructors_must_be_available
    errors.add(:instructor, " unfortunately not available at that time. Please email tickets@granlibakken.com to be notified if we have any instructors that become available.") unless available_instructors.any?
  end

  def requester_must_not_be_instructor
    errors.add(:instructor, "cannot request a lesson") unless self.requester.instructor.nil?
  end

  def lesson_time_must_be_valid
    errors.add(:lesson_time, "invalid") unless lesson_time.valid?
  end

  def student_exists
    puts "!!!!!checking if at least one student exists"
    errors.add(:students, "count must be greater than zero") unless students.any?
  end

  def age_validator
    puts "!!!!!!checking student ages"
    self.students.each do |student|
      if student.age_range.to_i < 8
        errors.add(:lesson, "error all students must be at least 8 years old")
        puts "!!! found a student under the age of 8"
        return false
      end
    end
    return true
  end

  def block_midweek_early_bird_sessions
    puts "!!!checking to see if user is trying to book Tues-Thurs at 8:30am"
    if self.date.nil?
      return false
    elsif HOLIDAYS.include?(self.date.to_s)
      return true
    elsif EARLY_SEASON_DATES.include?(self.date.to_s) && self.slot == "Early-bird 9am-10:30am"
      puts "!!!!!guest tried to book a 9am session in the early season. on these days sledding will start at 11am"
            errors.add(:lesson, "The 9am session start time is not available for most November and early December find_by_date_and_slot. Please select another slot starting at 11am or later.")
            return false
    else
      weekday = self.date.strftime('%A')
      midweek_blocked = ['Tuesday','Wednesday','Thursday']
      if midweek_blocked.include?(weekday) && self.slot == "Early-bird 9am-10:30am"
            puts "!!!!!guest tried to book a midweek 830am session. "
            errors.add(:lesson, "The 9am session start time is not available midweek (Tues-Thurs), but is available on weekends. Please select another slot.")
            return false
      else
        return true
      end
    end
  end

  def block_night_sessions_unless_fri_or_saturday
    puts "!!!checking to see if user is trying to book night sledding for any day Saturdays"
    if self.date.nil?
      return false
    else
      weekday = self.date.strftime('%A')
      return true if SPECIAL_NIGHT_SLEDDING_DATES.include?(self.date.to_s)
      non_night_sledding_days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday']
      if non_night_sledding_days.include?(weekday) && (self.slot == 'Night (5:00 PM - 6:30 PM) - special dates only' || self.slot == 'Night Sledding (7pm-8:30pm)')
            puts "!!!!!guest tried to book a nighttime session but not on Fri or Saturday."
            errors.add(:lesson, "Twilight and nightime sledding is not available on this date. Please select another session time or date, or email tickets@granlibakken.com with questions.")
            return false
      else
        return true
      end
    end
  end

  def check_night_sledding_against_blocked_dates
    puts "!!!checking to see if dates selected are blocked"
    if BLOCKED_NIGHT_SLEDDING_DATES.include?(self.date.to_s) && (self.slot == 'Night (5:00 PM - 6:30 PM) - special dates only')
          puts "!!!!!guest tried to book a nighttime session on a blocked date"
          errors.add(:lesson, "Unfortunately while night-time sledding is usually available every Sat night, it will not be happening on this date. Please contact guest services for more information.")
          return false
    else
      return true
    end
  end

  def check_preseason_against_blocked_dates
    puts "!!!checking to see if dates selected are blocked"
    if BLOCKED_EARLY_SEASON_DATES.include?(self.date.to_s)
          puts "!!!!!guest tried to book a sled session on a blocked date"
          errors.add(:lesson, "Unfortunately we are not expecting to have enough snow to have the sled hill open yet on this date. Please contact guest services for more information.")
          return false
    else
      return true
    end
  end

  def room_reservation_validator
    puts "!!!!!checking for valid resrvation id"
    if lodging_guest == false || lodging_guest.nil?
      return true
    elsif lodging_reservation_id.nil? || lodging_reservation_id.length != 6
      # errors.add(:lesson, "You must enter a valid room reservation id")
      puts "!!! invalid room reservation, but not preventing checkout"
      return true
    elsif lodging_reservation_id.length == 6
        return true
    end
  end

  def confirm_valid_promo_code
    return true if self.promo_code.nil?
    promo_redemptions_count = Lesson.where(promo_code_id:self.promo_code_id,state:'confirmed').count
    if promo_redemptions_count > 0 && self.promo_code.single_use == true
      errors.add(:lesson, "ERROR: Unfortunately your promo code has already been redeemed.")
      return false
    # weekday redemptions
    elsif self.promo_code.description == 'groupon 2-ticket weekday redemption' && (self.num_days !=2 || self.date.wday >4)
      errors.add(:lesson, "ERROR: Your promo code is valid for 2 students on Mon-Thurs. Please be sure to enter 2 student names and select an appropriate date. If you've reached this error already, please close this window and reopen your unique URL in a new tab.")
      return false
    elsif self.promo_code.description == 'groupon 4-ticket weekday redemption' && (self.num_days != 4 || self.date.wday >4)
      errors.add(:lesson, "ERROR: Your promo code is valid for 4 students on Mon-Thurs. Please be sure to enter 2 student names and select an appropriate date. If you've reached this error already, please close this window and reopen your unique URL in a new tab.")
      return false
    # weekend redemptions
    elsif self.promo_code.description == 'groupon 2-ticket weekend redemption' && (self.num_days !=2  || self.date.wday <=4)
      errors.add(:lesson, "ERROR: Your promo code is valid for 2 students on weekends only (Fri-Sun). Please be sure to enter 2 student names and select an appropriate date. If you've reached this error already, please close this window and reopen your unique URL in a new tab.")
      return false
    elsif self.promo_code.description == 'groupon 4-ticket weekend redemption' && (self.num_days != 4  || self.date.wday <=4)
      errors.add(:lesson, "ERROR: Your promo code is valid for 4 students on weekends only (Fri-Sun). Please be sure to enter 2 student names and select an appropriate date. If you've reached this error already, please close this window and reopen your unique URL in a new tab.")
      return false
    else
      return true
    end
  end

  def send_lesson_request_to_instructors
    return if self.state == "test_lesson"
    #currently testing just to see whether lesson is active and deposit has gone through successfully.
    #need to replace with logic that tests whether lesson is newly complete, vs. already booked, etc.
    if self.active? && self.confirmable? && self.deposit_status == 'confirmed' && self.state != "pending instructor" #&& self.deposit_status == 'verified'
      # LessonMailer.send_lesson_request_to_instructors(self).deliver
      self.send_sms_to_instructor
    elsif self.state != "Lesson Complete" && self.available_instructors.any? == false
      self.send_sms_to_admin
    end
  end

  def no_instructors_post_instructor_drop?
    pending_requester?
  end
end
