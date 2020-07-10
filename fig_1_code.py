import pandas as pd
from matplotlib import pyplot as plt
import matplotlib.ticker as ticker
import numpy as np


country_list = ['United States', 'United Kingdom', 'World', 'South Korea', 'China']

#load data and select relevant data
initial_df = pd.read_csv('owid-covid-data.csv')
initial_df = initial_df[['location', 'date', 'total_cases_per_million']]



#create final df
covid_df = initial_df[initial_df['location'].isin(country_list)].reset_index()
covid_df = covid_df[['location', 'date', 'total_cases_per_million']]

us_df = covid_df[covid_df['location'].isin(['United States'])].reset_index()
uk_df = covid_df[covid_df['location'].isin(['United Kingdom'])].reset_index()
world_df = covid_df[covid_df['location'].isin(['World'])].reset_index()
sk_df = covid_df[covid_df['location'].isin(['South_Korea'])].reset_index()
ch_df = covid_df[covid_df['location'].isin(['China'])].reset_index()

#Create line plot
ax = plt.subplot()

plt.plot(us_df['date'], us_df['total_cases_per_million'], color='purple')
plt.plot(uk_df['date'], uk_df['total_cases_per_million'], color='orange')
plt.plot(world_df['date'], world_df['total_cases_per_million'], color='green')
plt.plot(sk_df['date'], sk_df['total_cases_per_million'], color='red')
plt.plot(ch_df['date'], ch_df['total_cases_per_million'], color='blue')


plt.xlabel('')
plt.ylabel('Cases Per Million People')
plt.yscale('log')
plt.axis(['2020-01-22', '2020-05-08', -100, 5000])
plt.title('Total Confirmed COVID-19 Cases Per Million People')
ax.set_yticks([0.001, 0.01, 1, 10, 100, 1000])
ax.set_xticks(['2020-01-22','2020-03-01','2020-04-10', '2020-05-08'])
ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda y, _: '{:g}'.format(y)))
plt.legend(country_list, loc=0)
plt.show()
plt.savefig('covid_cases_per_million.png')