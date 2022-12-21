SLEDDING_SLOTS=['Early-bird 9am-10:30am','Morning (11am-12:30pm)','Midday (1pm-2:30pm)','Closing(3pm-4:30pm)','Night (5:00 PM - 6:30 PM) - special dates only']
# SLEDDING_SLOTS=['Early-bird (8:30-10am)','Morning (10:30am-12pm)','Midday (12:30-2pm)','Closing(2:30-4pm)','Saturday Dusk (4:30-6pm)','Spicy Saturday Night (6:30-8pm)']
LIFT_TICKET_SLOTS=['Child Lift Ticket','Adult Lift Ticket']
SNOWPLAY_SLOTS=['Snowplay Ticket']
NYE_SLOTS=['Saturday Dusk (4:30-6pm)','Spicy Saturday Night (6:30-8pm)']
AFTERSCHOOL_SLOTS=['Wed Afternoon(2:30-4pm)']

SLEDHILL_CAPACITY=ENV['SLEDHILL_CAPACITY'].to_i
SKIHILL_CAPACITY=ENV['SKIHILL_CAPACITY'].to_i

LESSON_SLOTS = [
'09:00  -  10:00am (first-timers only)',
'10:10 - 11:10am (first-timers only)',
'11:20 -  12:20pm',
'12:30 -1:30pm',
'2:20  -  3:20pm (optional private)',
'3:30  -  4:30pm (optional private)'].freeze

BLOCKED_NIGHT_SLEDDING_DATES = ['2022-11-26','2022-12-03','2022-12-10','2022-12-24']
SPECIAL_NIGHT_SLEDDING_DATES = ['2022-12-17','2022-12-23','2022-12-30','2022-12-31','2023-01-06','2023-01-06','2023-01-07','2023-01-13','2023-01-14']
EARLY_SEASON_DATES = ['2022-11-28','2022-11-29','2022-11-30','2022-12-01',
	'2022-12-05','2022-12-06','2022-12-07','2022-12-08']

HOLIDAYS = ['2022-11-24','2022-11-25','2022-11-26','2022-11-27','2022-12-19','2022-12-20','2022-12-21','2022-12-22','2022-12-23','2022-12-24','2022-12-25','2022-12-26','2022-12-27','2022-12-28','2022-12-29','2022-12-30','2022-12-31','2023-01-01','2023-01-02','2023-01-03','2023-01-04','2023-01-05','2023-01-06','2023-01-07','2023-01-08','2023-01-09','2023-01-13','2023-01-14','2023-01-15','2023-01-16','2023-02-10','2023-02-11','2023-02-12','2023-02-13','2023-02-14','2023-02-15','2023-02-16','2023-02-17','2023-02-18','2023-02-19','2023-02-20','2023-02-21','2023-02-22','2023-02-23','2023-02-24','2023-02-25','2023-02-26','2023-02-27']

WEEKENDS = ['2022-12-17','2022-12-18','2023-01-07','2023-01-08','2023-01-14','2023-01-15','2023-01-21','2023-01-22','2023-01-28','2023-01-29',
	'2023-02-04','2023-02-05','2023-02-11','2023-02-12','2023-02-18','2023-02-19','2023-02-25','2023-02-26',
	'2023-03-04','2023-03-05','2023-03-11','2023-03-12','2023-03-18','2023-03-19','2023-03-25','2023-03-26',
	'2023-04-01','2023-04-02','2023-04-08','2023-04-09']

NON_HOLIDAYS = ['2022-12-09','2022-12-10','2022-12-11','2022-12-12','2022-12-13','2022-12-14','2022-12-15','2022-12-16','2022-12-17','2022-12-18','2023-01-09','2023-01-10','2023-01-11','2023-01-12',
	'2023-01-17','2023-01-18','2023-01-19','2023-01-20','2023-01-21','2023-01-22','2023-01-23','2023-01-24','2023-01-25','2023-01-26','2023-01-27','2023-01-28','2023-01-29','2023-01-30','2023-01-31',
	'2023-02-01','2023-02-02','2023-02-03','2023-02-04','2023-02-05','2023-02-06','2023-02-07','2023-02-08','2023-02-09',
	'2023-02-28','2023-02-29','2023-03-01','2023-03-02','2023-03-03','2023-03-04','2023-03-05','2023-03-06','2023-03-07','2023-03-08','2023-03-09','2023-03-10','2023-03-11','2023-03-12','2023-03-13','2023-03-14','2023-03-15','2023-03-16','2023-03-17','2023-03-18','2023-03-19','2023-03-20','2023-03-21','2023-03-22','2023-03-23','2023-03-24','2023-03-25','2023-03-26','2023-03-27','2023-03-28','2023-03-29','2023-03-30','2023-03-31','2023-04-01','2023-04-02','2023-04-03','2023-04-04','2023-04-05']