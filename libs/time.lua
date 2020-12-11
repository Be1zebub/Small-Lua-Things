local time = {}

time.second = 1
time.sec = 1

time.minute = time.second * 60
time.min = time.sec * 60

time.hour = time.minute * 60

time.day = time.hour * 24

time.week = time.day * 7

time.month = time.day * 30

time.year = time.month * 12

return time
