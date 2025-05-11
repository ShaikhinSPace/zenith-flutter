##########################################################################
# name: Sameer Alam Shaikh  
# date: May 6, 2025
# description: This program compares the population growth of two countries
#              over a specified time period using user-provided inputs for
#              initial populations and growth rates.
#########################################################################

# A function that prints out the introduction to the program. It doesn't
# take any arguments and does not return any results.
def print_introduction():
    print("This program will compare the populations of two different countries")
    print("over time")

# A function that prompts the user for the name of the country. It takes
# in a number that is used in the prompt as an argument. It then returns
# the name of the country.
def get_country_name(country_number):
    country_name = input(f"What is the name of Country #{country_number}: ")
    return country_name

# A function that prompts the user for the current population of a
# country. It takes the name of the country as an argument, and then
# returns the resulting population. The function also carries out range
# checking to make sure the value inputed by the user is valid (i.e. not
# negative)
def get_population(country_name):
    while True:
        try:
            population = int(input(f"What is the current population of {country_name}? "))
            if population <= 0:
                print("That doesn't seem right. Please enter a positive number")
            else:
                return population
        except ValueError:
            print("Please enter a valid number")

# A function that prompts the user for the population growth rate of a
# country. It takes in the name of the country as an argument and then
# returns a value growth rate. It also carries out range checking to
# make sure that the result is not an unrealistic growth rate i.e. rate
# should be between -5 and 10 inclusive.
def get_growth_rate(country_name):
    while True:
        try:
            growth_rate = float(input(f"What is the annual population growth rate of {country_name}? "))
            if growth_rate < -5 or growth_rate > 10:
                print("That doesn't seem right. Please enter a value in the range [-5,10]")
            else:
                return growth_rate
        except ValueError:
            print("Please enter a valid number")
        
# A function that prompts the user for the number of years to show in
# the resulting table. The function doesn't take any arguments but
# returns a result. It is also in charge of range checking to make sure
# that the number of years is not less than 1.
def get_duration():
    while True:
        try:
            duration = int(input("How many years of comparison should the table show? "))
            if duration < 1:
                print("That doesn't seem right. Please enter a value >= 1")
            else:
                return duration
        except ValueError:
            print("Please enter a valid number")

# A function that prompts the user for the duration of the interval in
# the table i.e. how many years between each successive row of the
# resulting table. It doesn't take any arguments and does range checking
# to make sure that the user doesn't enter a value less than 1.
def get_interval():
    while True:
        try:
            interval = int(input("How many years should the intervals be? "))
            if interval < 1:
                print("That doesn't seem right. Please enter a value >= 1")
            else:
                return interval
        except ValueError:
            print("Please enter a valid number")

# A function that calculates the population given an intial population,
# a growth rate, and the time. It takes 3 arguments (population, growth
# rate and time) and returns the resulting population.
def calculate_population(initial_population, growth_rate, time):
    # Formula: f = p * (1 + r/100)^t
    final_population = initial_population * ((1 + growth_rate/100) ** time)
    return int(final_population)  # Round to nearest integer

# A functiont to print out the header of the table. It takes two
# arguments i.e. the country names, and then prints out the formatting
# lines as well as the first row seen at the top of the table.
def print_table_header(country1_name, country2_name):
    print("-" * 50)
    print(f"{'Years':<10}{country1_name:<20}{country2_name:<20}")
    print("-" * 50)

# A function to print out the rest of the table row by row. It receives
# 6 arguments: both country populations, both country rates, the
# duration of the analysis and the interval between each row. It then
# relies on calculate population function to calculate the population
# values for each row and print them out in order.
def print_table_body(country1_pop, country2_pop, country1_rate, country2_rate, duration, interval):
    # Print initial row (year 0)
    print(f"{'0':<10}{country1_pop:,}{' ':<10}{country2_pop:,}")
    
    # Print rows for each interval
    for year in range(interval, duration + 1, interval):
        pop1 = calculate_population(country1_pop, country1_rate, year)
        pop2 = calculate_population(country2_pop, country2_rate, year)
        print(f"{year:<10}{pop1:,}{' ':<10}{pop2:,}")

############### MAIN ##################################
# print the introduction
print_introduction()

# Get the country names
country1_name = get_country_name(1)
country2_name = get_country_name(2)

# Get the country initial populations
country1_pop = get_population(country1_name)
country2_pop = get_population(country2_name)

# get the country population growth rates
country1_rate = get_growth_rate(country1_name)
country2_rate = get_growth_rate(country2_name)

# get the analysis detais e.g. the duration and the interval
duration = get_duration()
interval = get_interval()

def main(): 
    # Print out the table header
    print_table_header(country1_name, country2_name)
    
    # Print out the table body
    print_table_body(country1_pop, country2_pop, country1_rate, country2_rate, duration, interval)
    
    # Print out the table footer
    print("-" * 50)

if __name__ == "__main__":
    main()