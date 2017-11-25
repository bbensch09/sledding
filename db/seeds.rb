User.delete_all
Instructor.delete_all

Sport.find_or_create_by!({name: "Ski Instructor"})
Sport.find_or_create_by!({name: "Snowboard Instructor"})
puts "sports created"

ski_levels = ["Level 1 - first-time ever, no previous experience.",
              "Level 2 - can safely stop on beginner green circle terrain.",
              "Level 3 - can makes wedge turns (heel-side turns for snowboarding) in both directions on beginner terrain.",
              "Level 4 - can link turns with moderate speed on all beginner terrain.",
              "Level 5 - can make mostly parallel turns (S-turns for snowboarding) and safely navigate intermediate runs.",
              "Level 6 - can confidently link parallel turns across all intermediate terrain.",
              "Level 7 - can control speed, rhythm, and shape of turns across variety of intermediate and advanced terrain.",
              "Level 8 - can ski moguls and off-piste terrain in all snow conditions.",
              "Level 9 - can confidently and safely ski expert-only (double-black diamond) terrain."]

if SkiLevel.count == 0

  ski_levels.each do |level|
    SkiLevel.create!({
    name: level,
    value: SkiLevel.count + 1
    })

    SnowboardLevel.create!({
    name: level,
    value: SnowboardLevel.count + 1
    })
  end
end
puts "Ski and snowboard level 1-9 created."

User.create!({
  email: "brian@snowschoolers.com",
  password: "password",
  user_type: "Snow Schoolers Employee",
  location_id: 24
  })

Instructor.create!({
  first_name: "Brian",
  last_name: "Bensch",
  username: "brian@snowschoolers.com",
  phone_number: "408-315-2900",
  city: "San Francisco",
  certification: "Level 1 PSIA",
  intro: "I am the founder.",
  bio: "I am the best instructor on the mountain. period.",
  location_ids: 24,
  adults_initial_rank: 10,
  kids_initial_rank: 10,
  overall_initial_rank: 10,
  status: 'Active',
  age: 30,
  user_id: User.first.id
  })

gb_seed_accounts = [
  "brian+chris@snowschoolers.com",
  "brian+ron@snowschoolers.com",
  "brian+stephanie@snowschoolers.com",
]

gb_seed_accounts.each do |email|
User.create!({
  email: email,
  password: "password",
  user_type: "Partner",
  location_id: 24
  })

puts "User created: #{User.last.email}."

Instructor.find_or_create_by!({
  user_id: User.last.id,
  first_name: ['Chris','Ron','Stephanie'].sample,
  last_name: 'Parsons',
  username: email,
  phone_number: "408-315-2900",
  city: ['Tahoe City, CA', 'Truckee, CA','South Lake Tahoe, CA'].sample,
  certification: ['PSIA Level 1','PSIA Level 2','PSIA Level 3','AASI Level 1','AASI Level 2','AASI Level 3'].sample,
  intro: "I want to teach for Snow Schoolers!!!!",
  bio: "Chris hails from New York where he learned to ski as a kid and first began teaching children's ski lessons in high school at the local resort. He later coached the traveling freestyle ski team, and eventually moved to Crested Butte to live the ski bum dream for awhile, which included competing in the U.S. Freeskiing Championships. He recently moved to Tahoe 5 years ago. With nearly three decades of instructor experience across all skill levels, he will happily share his local secrets and ensure you have a wonderful experience on the mountain..",
  adults_initial_rank: rand(5..10),
  kids_initial_rank: rand(5..10),
  overall_initial_rank: rand(5..10),
  age: [20..40].sample,
  status: 'Active',
  how_did_you_hear: 5
  })

puts "Instructor created: #{Instructor.last.first_name}."

end

User.confirm_all_users
puts "all users confirmed"


Instructor.all.each do |instructor|
  instructor.location_ids = [24]
  instructor.sport_ids = [1,2]
  instructor.save
end

Instructor.seed_instructor_levels 

puts "instructor locations & levels assigned"
puts "seed complete, locations created."



# BEGIN seed file to setup for Demo
# Instructor.seed_temp_instructors

# (0...5).to_a.each do |day_num|
#     puts "!!! - beginning to create lessons, shifts, sections for day_num: #{day_num}"
#     num_lessons = (15..55).to_a.sample
#     Shift.create_instructor_shifts(Date.today+day_num)
#     Section.seed_sections(Date.today+day_num)
#     Lesson.seed_lessons(Date.today+day_num,num_lessons)
#   end
#     puts "!!!! completed seeding for 5 days"
