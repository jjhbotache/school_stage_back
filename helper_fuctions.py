import datetime

def add_business_days(days,start_date=(datetime.date.today())):
    current_date = start_date
    days_added = 0

    while days_added < days:
        current_date += datetime.timedelta(days=1)

        # If it's a business day (Monday to Friday)
        if current_date.weekday() < 5:
            days_added += 1

    return current_date.strftime("%Y-%m-%d")

# Get the current date

# Add 4 business days
# result_date = add_business_days(4)

# print("Result date:", result_date)
# print("type:", type(result_date))
