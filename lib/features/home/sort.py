##########################################################################
# name:
# date:
# description: Population growth comparison over time for two countries.
#########################################################################

# A function that prints out the introduction to the program. It doesn't
# take any arguments and does not return any results.
def print_intro():
    print("This program will compare the populations of two different countries over time.")

# A function that prompts the user for the name of the country. It takes
# in a number that is used in the prompt as an argument. It then returns
# the name of the country.
def get_country_name(number):
    return input(f"What is the name of Country #{number}: ")

# A function that prompts the user for the current population of a
# country. It takes the name of the country as an argument, and then
# returns the resulting population. The function also carries out range
# checking to make sure the value inputed by the user is valid (i.e. not
# negative)
def get_population(country_name):
    valid = False
    while not valid:
        value = int(input(f"What is the current population of {country_name}? "))
    return value

# A function that prompts the user for the population growth rate of a
# country. It takes in the name of the country as an argument and then
# returns a value growth rate. It also carries out range checking to
# make sure that the result is not an unrealistic growth rate i.e. rate
# should be between -5 and 10 inclusive.
def get_growth_rate(country_name):
    valid = False
    while not valid:
        value = float(input(f"What is the annual population growth rate of {country_name}? "))
    return value


# A function that prompts the user for the number of years to show in
# the resulting table. The function doesn't take any arguments but
# returns a result. It is also in charge of range checking to make sure
# that the number of years is not less than 1.
def get_duration():
    value = int(input("How many years of comparison should the table show? "))
    return value

# A function that prompts the user for the duration of the interval in
# the table i.e. how many years between each successive row of the
# resulting table. It doesn't take any arguments and does range checking
# to make sure that the user doesn't enter a value less than 1.
def get_interval():
    value = int(input("How many years should the intervals be? "))
    return value

# A function that calculates the population given an intial population,
# a growth rate, and the time. It takes 3 arguments (population, growth
# rate and time) and returns the resulting population.
def calculate_population(population, growth_rate, time):
    return population * ((1 + growth_rate / 100) ** time)

# A functiont to print out the header of the table. It takes two
# arguments i.e. the country names, and then prints out the formatting
# lines as well as the first row seen at the top of the table.
def print_table_header(country1, country2):
    print("-" * 50)
    print(f"{'Years':<6} {country1:<15} {country2}")
    print("-" * 50)

# A function to print out the rest of the table row by row. It receives
# 6 arguments: both country populations, both country rates, the
# duration of the analysis and the interval between each row. It then
# relies on calculate population function to calculate the population
# values for each row and print them out in order.
def print_table_body(duration, interval, pop1, pop2, rate1, rate2):
    for year in range(0, duration + 1, interval):
        new_pop1 = int(calculate_population(pop1, rate1, year))
        new_pop2 = int(calculate_population(pop2, rate2, year))
        print(f"{year:<6} {new_pop1:<15,} {new_pop2:<15,}")
    print("-" * 50)


############### MAIN ##################################

# print the introduction
def main():
    print_intro()

    # Get the country names
    country1 = get_country_name(1)
    country2 = get_country_name(2)

    # Get the country initial populations
    pop1 = get_population(country1)
    pop2 = get_population(country2)

    # get the country population growth rates
    rate1 = get_growth_rate(country1)
    rate2 = get_growth_rate(country2)

    # get the analysis detais e.g. the duration and the interval
    duration = get_duration()
    interval = get_interval()

    # Print out the table
    print_table_header(country1, country2)
    print_table_body(duration, interval, pop1, pop2, rate1, rate2)

main()
