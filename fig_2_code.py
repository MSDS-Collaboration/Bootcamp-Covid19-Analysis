import pandas as pd
from matplotlib import pyplot as plt
import matplotlib.ticker as ticker
import numpy as np
import plotly.express as px


country_list = ['United States', 'United Kingdom', 'World', 'South Korea', 'China']

#load data and select relevant data
initial_df = pd.read_csv('owid-covid-data.csv')
initial_df = initial_df[['iso_code', 'location', 'date', 'total_cases_per_million']]
initial_df = initial_df.loc[initial_df['date'] == '2020-07-09']

#create map plot
fig = px.choropleth(initial_df, locations='iso_code',
                        hover_name='location',
                        color='total_cases_per_million',
                        color_continuous_scale=px.colors.sequential.Reds,
                        range_color=[0,5000])

fig.show()
