import statsmodels.api as sm
import pandas as pd
import matplotlib.pyplot as plt

# Declare a function to get the rolling statistics


def get_trend(y, window):
    rollmean = y.rolling(window=window, center=False).mean()
    rollstd = y.rolling(window=window, center=False).std()
    return rollmean, rollstd


# Read from a CSV file data regarding tickets sales
# over a period of time for several festivals
df = pd.read_csv('./resources/festival_ticks_sales.csv')

# Check data format
print(df.head())


# Plot a line graphic
df.plot(kind='line', title='Number of tickets sold')
plt.legend(bbox_to_anchor=(1.12, 1), loc='upper right', title='Festivals')
plt.show()

# Show trends (rolling avg, rolling std dev) over several windows: 1 week, 2 weeks, 1 month
windows = [7, 14, 30]

# Show trend evolution of Untold

for window in windows:
    trendline = get_trend(df['Untold'], window=window)
    plt.plot(df['Untold'],  color='blue',
             label='Tickets sold (original)')
    plt.plot(trendline[0], color='red', label=f'Trend {window} days (avg)')
    plt.plot(trendline[1], color='black',
             label=f'Trend {window} days (std. dev.)')
    plt.legend(loc='best')
    plt.show()

# Show trend evolution of Neversea

for window in windows:
    trendline = get_trend(df['Neversea'], window=window)
    plt.plot(df['Neversea'], color='blue',
             label='Tickets sold (original)')
    plt.plot(trendline[0], color='red', label=f'Trend {window} days (avg)')
    plt.plot(trendline[1], color='black',
             label=f'Trend {window} days (std. dev.)')
    plt.legend(loc='best')
    plt.show()

# Show trend evolution of Burning Man

for window in windows:
    trendline = get_trend(df['Burning Man'], window=window)
    plt.plot(df['Burning Man'], color='blue',
             label='Tickets sold (original)')
    plt.plot(trendline[0], color='red', label=f'Trend {window} days (avg)')
    plt.plot(trendline[1], color='black',
             label=f'Trend {window} days (std. dev.)')
    plt.legend(loc='best')
    plt.show()

# Create a linear regression model check if Untold tickets sales
# are related to Neversea and Burning Man tickets sales using a OLS
# regression model
model = sm.OLS(df['Untold'], df['Neversea'])
res = model.fit()
print(res.summary())
