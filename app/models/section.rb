class Section < ApplicationRecord
	has_many :lessons
	belongs_to :sport
	belongs_to :instructor
	belongs_to :shift
	# validate :no_double_booking_instructors, on: :update

	# def name
	# 	return "#{self.age_group} #{self.lesson_type} - #{self.sport.activity_name}"
	# end

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
		if self.sport.name == "Ski Instructor"
			return "Skiing"
		else
			return "Snowboarding"
		end
	end

	def self.fill_sections_with_lessons
		Section.all.each do |section|
			
			until section.has_capacity? == false
				lt = LessonTime.find_or_create_by({
					date: section.date,
					slot: section.slot
					})
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
					product_name: ['Group Package','Group Lesson Only'].sample
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
			end
		end
	end
# '10:10 - 11:10am (first-timers only)','11:20 -  12:20pm','12:30 -1:30pm  (first-timers only)','2:20  -  3:20pm','3:30  -  4:30pm'
	def self.seed_sections(date = Date.today)
		#9am - 10am
		Section.create!({
			date: date,
			name: 'Beginner Skiing',
			slot: '09:00  -  10:00am',
			sport_id: 1,
			level: 'Beginner',
			capacity: 6
			})
		Section.create!({
			date: date,
			name: 'Beginner Snowboarding',
			slot: '09:00  -  10:00am',
			sport_id: 2,
			level: 'Beginner',
			capacity: 6
			})
		#1010am -- deliveries
		Section.create!({
			date: date,
			name: 'First-timers: Skiing',
			slot: '10:10 - 11:10am (first-timers only)',
			sport_id: 1,
			level: 'First-timer',
			capacity: 6
			})
		Section.create!({
			date: date,
			name: 'First-timers: Snowboarding',
			slot: '10:10 - 11:10am (first-timers only)',
			sport_id: 2,
			level: 'First-timer',
			capacity: 6
			})
		#1120 - beginners
		Section.create!({
			date: date,
			name: 'Beginner Skiing',
			slot: '11:20  -  12:20pm',
			sport_id: 1,
			level: 'Beginner',
			capacity: 6
			})
		Section.create!({
			date: date,
			name: 'Beginner Snowboarding',
			slot: '11:20  -  12:20pm',
			sport_id: 2,
			level: 'Beginner',
			capacity: 6
			})
		#dashboard to compare by channels
		Section.create!({
			date: date,
			name: 'First-timers: Skiing',
			slot: '10:10 - 11:10am (first-timers only)',
			sport_id: 1,
			level: 'First-timer',
			capacity: 6
			})
		Section.create!({
			date: date,
			name: 'First-timers: Skiing',
			slot: '10:10 - 11:10am (first-timers only)',
			sport_id: 2,
			level: 'First-timer',
			capacity: 6		
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
