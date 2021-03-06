SLEDDING_SLOTS=['Morning (10:30am-12pm)','Midday (12:30-2pm)','Closing(2:30-4pm)','Saturday Dusk (4:30-6pm)','Spicy Saturday Night (6:30-8pm)']
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

HOLIDAYS = ['2020-12-19','2020-12-20','2020-12-21','2020-12-22','2020-12-23','2020-12-24','2020-12-25','2020-12-26','2020-12-27','2020-12-28','2020-12-29','2020-12-30','2020-12-31','2021-01-01','2021-01-02','2021-01-03','2021-01-16','2021-01-17','2021-01-18','2021-02-13','2021-02-14','2021-02-15','2021-02-16','2021-02-17','2021-02-18','2021-02-19','2021-02-20','2021-02-21']

WEEKENDS = ['2021-01-02','2021-01-03','2021-01-09','2021-01-10','2021-01-16','2021-01-16','2021-01-23','2021-01-24','2021-01-30','2021-01-31','2021-02-06','2021-02-07','2021-02-13','2021-02-14','2021-02-20','2021-02-21','2021-02-27','2021-02-28','2021-03-06','2021-03-07','2021-03-13','2021-03-14','2021-03-20','2021-03-21','2021-03-27','2021-03-28','2021-04-03','2021-04-04','2021-04-10','2021-04-11','2021-04-17','2021-04-18']

NON_HOLIDAYS = ['2020-12-09','2020-12-10','2020-12-11','2020-12-12','2020-12-13','2020-12-14','2020-12-15','2021-01-08','2021-01-09','2021-01-10','2021-01-21','2021-01-25','2021-01-26','2021-01-27','2021-01-28','2021-02-01','2021-02-02','2021-02-03','2021-02-04','2021-02-08','2021-02-09','2021-02-10','2021-02-11','2021-02-24','2021-02-25','2021-02-26','2021-02-27','2021-02-28','2021-02-29','2021-03-01','2021-03-02','2021-03-03','2021-03-04','2021-03-05','2021-03-06','2021-03-07','2021-03-08','2021-03-09','2021-03-10','2021-03-11','2021-03-12','2021-03-13','2021-03-14','2021-03-15','2021-03-16','2021-03-17','2021-03-18','2021-03-19','2021-03-20','2021-03-21','2021-03-22','2021-03-23','2021-03-24','2021-03-25','2021-03-26','2021-03-27','2021-03-28','2021-03-29','2021-03-30','2021-03-31','2021-04-01','2021-04-02','2021-04-03','2021-04-04','2021-04-05']