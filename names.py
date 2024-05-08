import pandas as pd
import requests
from bs4 import BeautifulSoup
import time


# Function to scrape names for a given year
def scrape_names(year):
    # Construct the URL with the provided year
    url = f'https://www.beliebte-vornamen.de/jahrgang/j{year}'

    # Fetch the HTML content
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')

    # Select both columns of names
    list_of_names = soup.select('div table tr td:nth-of-type(1) a, div table tr td:nth-of-type(2) a')

    # Extract names and determine the number of names retrieved for each gender
    results = [r.text.split(' ')[0].strip() for r in list_of_names]
    num_names_female = len(results) // 2
    num_names_male = len(results) - num_names_female

    # Create list of genders based on the number of names retrieved
    genders = ['f'] * num_names_female + ['m'] * num_names_male

    # Create DataFrame
    df = pd.DataFrame({'Names': results, 'Gender': genders})

    # Reset Placement for each gender
    df.loc[df['Gender'] == 'f', 'Placement'] = range(1, num_names_female + 1)
    df.loc[df['Gender'] == 'm', 'Placement'] = range(1, num_names_male + 1)

    # Convert 'Placement' column to integer type
    df['Placement'] = df['Placement'].astype(int)

    # Add Year column
    df['Year'] = year

    return df


# Iterate through the range of years and collect data
start_year = 1890
end_year = 2018
dfs = []

for year in range(start_year, end_year + 1):
    df = scrape_names(year)
    dfs.append(df)
    time.sleep(1)  # Add a delay of 1 second between each call

# Concatenate all DataFrames
final_df = pd.concat(dfs, ignore_index=True)

# Save the DataFrame to a CSV file
final_df.to_csv('names.csv', index=False)
