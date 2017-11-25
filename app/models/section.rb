class Section < ApplicationRecord
	has_many :lessons
	belongs_to :sport
	belongs_to :instructor
	belongs_to :shift
	# validate :no_double_booking_instructors, on: :update

	# def name
	# 	return "#{self.age_group} #{self.lesson_type} - #{self.sport.activity_name}"
	# end
	def start_time
		self.date
	end

	def activity
		if self.sport_id == 1
			return 'Ski'
		elsif self.sport_id == 2
			return 'Snowboard'
		end			
	end

	def status
		if self.has_capacity?
			return 'Available'
		else
			return 'Full'
		end
	end

	def section_status_color
	  	case self.status
	  	when 'Full'
	  		return 'red-shift'
	  	when 'Available'
	  		return 'green-shift'
		else
	  		return 'blue-shift'
	  	end
  	end

	 def available_instructors
	    if self.instructor_id && self.instructor_id.to_i > 0
	      return [self.instructor]
	    else
	    resort_instructors = Location.find(24).instructors
	    puts "!!!!!!! - Step #1 Filtered for Granlibakken, found #{resort_instructors.count} instructors."
	    active_resort_instructors = resort_instructors.where(status:'Active')
	    puts "!!!!!!! - Step #2 Filtered for active status, found #{active_resort_instructors.count} instructors."
	    
	    if self.sport_name == 'Skiing'
	        active_resort_instructors = active_resort_instructors.to_a.keep_if {|instructor| instructor.ski_instructor? }
	      elsif self.sport_name == "Snowboarding"
	        active_resort_instructors = active_resort_instructors.to_a.keep_if {|instructor| instructor.snowboard_instructor? }
	    end
	    puts "!!!!!!! - Step 3 Filtered for correct sport."
	    already_booked_instructors = []#self.lesson.booked_instructors(lesson_time)
	    busy_instructors = [] #self.lesson.instructors_with_calendar_blocks(lesson_time)
	    available_instructors = active_resort_instructors - already_booked_instructors - busy_instructors
	    puts "!!!!!!! - Step #5 after all filters, found #{available_instructors.count} instructors."
	    available_instructors.sort! {|a,b| b.overall_score <=> a.overall_score }
	    return available_instructors
	    end
	  end

	def instructor_name_for_section
		if self.instructor_id && self.instructor_id.to_i > 0
			return self.instructor.name
		else
			return "Not yet assigned"
		end
	end

	def self.available_section_splits(date, age_type)
		Section.where(date:date,age_group:age_type)
	end

	def parametized_date
		return "#{self.date.strftime("%m")}%2F#{self.date.strftime("%d")}%2F#{self.date.strftime("%Y")}"
	end

	def sport_name
		if self.sport_id == 1
			return "Skiing"
		else
			return "Snowboarding"
		end
	end

	def self.delete_all_lessons
		Section.all.each do |section|
			section.lessons.each do |lesson|
				lesson.destroy!
			end
		end
	end

	def self.fill_sections_with_lessons
		puts "!!!!!Begin method: self.fill_sections_with_lessons"
		sections = Section.all.select{|a| a.date >= Date.today }
		sections.first(20).each do |section|		
			
			until section.remaining_capacity <= 1
				lt = LessonTime.find_or_create_by({
					date: section.date,
					slot: section.slot
					})
				puts "!!!!!new lesson time created"
				Lesson.create!({
					requester_id: User.first.id,
					guest_email: 'test@example.com',
					instructor_id: Instructor.first.id,
					lesson_time_id: lt.id,
					deposit_status: 'confirmed',
					activity: ['Ski','Snowboard'].sample,
					requested_location: 24,
					phone_number: '555-555-5555',
					gear: true,
					lift_ticket_status: true,
					objectives: 'Test lesson',
					state: 'booked',
					terms_accepted: true,
					how_did_you_hear: 100,
					requester_name: 'John Parent',
					product_id: Product.where(location_id:24,length:"1.00",product_type:'learn_to_ski',calendar_period:"Regular").first.id,
					section_id: section.id,
					product_name: ['Group Package','Group Lesson Only'].sample,
					state: "test_lesson"
					})
				Student.create!({
					lesson_id: Lesson.last.id,
					name: 'Tommy Student',
					age_range: 10,
					gender: ['Male','Female'].sample,
					relationship_to_requester: 'Student is my child',
					most_recent_level: "Level 1 - first-time ever, no previous experience.", 
					requester_id: User.first.id					
					})
				puts "!!!! new lesson created"
			end
		end
	end

	def self.duplicate_ski_section(date,slot)
		Section.create!({
			date: date,
			name: 'Beginner Skiing',
			slot: slot,
			sport_id: 1,
			level: 'Beginner',
			capacity: 6
			})		
	end

	def self.duplicate_snowboard_section(date,slot)
		Section.create!({
			date: date,
			name: 'Beginner Skiing',
			slot: slot,
			sport_id: 2,
			level: 'Beginner',
			capacity: 6
			})		
	end

	def self.generate_all_sections
		dates = ['2017-11-18','2017-11-19','2017-11-23','2017-11-24','2017-11-25','2017-11-26','2017-12-01','2017-12-02','2017-12-03','2017-12-04','2017-12-08','2017-12-09','2017-12-10','2017-12-11','2017-12-15','2017-12-16','2017-12-17','2017-12-18','2017-12-22','2017-12-23','2017-12-24','2017-12-25','2017-12-26','2017-12-27','2017-12-28','2017-12-29','2017-12-30','2017-12-31','2018-01-01','2018-01-02','2018-01-03','2018-01-04','2018-01-05','2018-01-06','2018-01-07','2018-01-08','2018-01-12','2018-01-13','2018-01-14','2018-01-15','2018-01-19','2018-01-20','2018-01-21','2018-01-22','2018-01-26','2018-01-27','2018-01-28','2018-01-29','2018-02-02','2018-02-03','2018-02-04','2018-02-05','2018-02-09','2018-02-10','2018-02-11','2018-02-12','2018-02-16','2018-02-17','2018-02-18','2018-02-19','2018-02-20','2018-02-21','2018-02-22','2018-02-23','2018-02-24','2018-02-25','2018-02-26','2018-03-02','2018-03-03','2018-03-04','2018-03-05','2018-03-09','2018-03-10','2018-03-11','2018-03-12','2018-03-16','2018-03-17','2018-03-18','2018-03-19','2018-03-23','2018-03-24','2018-03-25','2018-03-26','2018-03-30','2018-03-31','2018-04-01','2018-04-02','2018-04-06','2018-04-07','2018-04-08','2018-04-09','2018-04-13','2018-04-14','2018-04-15']
		dates.each do |date|
			Section.seed_sections(date)
		end
	end

	def self.seed_sections(date = Date.today)
		#9am - 10am
		Section.create!({
			date: date,
			name: 'Beginner Skiing',
			slot: LESSON_SLOTS.first,
			sport_id: 1,
			level: 'Beginner',
			capacity: 5
			})
		Section.create!({
			date: date,
			name: 'Beginner Snowboarding',
			slot: LESSON_SLOTS.first,
			sport_id: 2,
			level: 'Beginner',
			capacity: 5
			})
		#1010am -- deliveries
		Section.create!({
			date: date,
			name: 'First-timers: Skiing',
			slot: LESSON_SLOTS.second,
			sport_id: 1,
			level: 'First-timer',
			capacity: 5
			})
		Section.create!({
			date: date,
			name: 'First-timers: Snowboarding',
			slot: LESSON_SLOTS.second,
			sport_id: 2,
			level: 'First-timer',
			capacity: 5
			})
		#1120 - beginners
		Section.create!({
			date: date,
			name: 'Beginner Skiing',
			slot: LESSON_SLOTS.third,
			sport_id: 1,
			level: 'Beginner',
			capacity: 5
			})
		Section.create!({
			date: date,
			name: 'Beginner Snowboarding',
			slot: LESSON_SLOTS.third,
			sport_id: 2,
			level: 'Beginner',
			capacity: 5
			})
		Section.create!({
			date: date,
			name: 'First-timers: Skiing',
			slot: LESSON_SLOTS.fourth,
			sport_id: 1,
			level: 'First-timer',
			capacity: 5
			})
		Section.create!({
			date: date,
			name: 'First-timers: Skiing',
			slot: LESSON_SLOTS.fourth,
			sport_id: 2,
			level: 'First-timer',
			capacity: 5		
		})
		Section.create!({
			date: date,
			name: 'Beginner Skiing',
			slot: LESSON_SLOTS.fifth,
			sport_id: 1,
			level: 'Beginner',
			capacity: 5
			})
		Section.create!({
			date: date,
			name: 'Beginner Snowboarding',
			slot: LESSON_SLOTS.fifth,
			sport_id: 2,
			level: 'Beginner',
			capacity: 5
			})
		Section.create!({
			date: date,
			name: 'Beginner Skiing',
			slot: LESSON_SLOTS[5],
			sport_id: 1,
			level: 'Beginner',
			capacity: 5
			})
		Section.create!({
			date: date,
			name: 'Beginner Snowboarding',
			slot: LESSON_SLOTS[5],
			sport_id: 2,
			level: 'Beginner',
			capacity: 5
			})

	end

	def student_count
		count = 0
		lessons = Lesson.where(section_id:self.id)
		lessons.each do |lesson|
			unless lesson.state == 'canceled'
				lesson.students.each do |student|
					count += 1
				end
			end
		end
		return count
	end

	def capacity_text
		spots = [4,self.remaining_capacity].min
		"#{spots} spots left."
	end

	def slot_short
		case slot
			when LESSON_SLOTS.first
				return '9am'
			when  LESSON_SLOTS.second
				return '10:10am'
			when LESSON_SLOTS.third
				return '11:20am'
			when LESSON_SLOTS.fourth
				return '12:30pm'
			when LESSON_SLOTS.fifth
				return '2:20pm'
			when LESSON_SLOTS.last
				return '330pm'
			end
	end

	def remaining_capacity
		self.capacity - self.student_count
	end

	def has_capacity?
		self.capacity > self.student_count
	end

	def no_double_booking_instructors
		#TBD - tricky due to nature of AM & PM sections	
	    # errors.add(:section, "cannot double book an instructor") unless Instructor.count == 0
	end

end
