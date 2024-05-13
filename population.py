import pandas as pd
import numpy as np

df_usa_names = pd.read_csv('usa.csv')
df_french_names = pd.read_csv('french_names.csv', delimiter=';')
df_spanish_names = pd.read_csv('spain.csv', delimiter=';')

# Remove commas from the 'Population' column and convert to integers
df_usa_names['Population'] = df_usa_names['Population'].str.replace(',', '').astype(int)

# Handle NA values
df_french_names = df_french_names.dropna(subset=['Population'])
df_spanish_names = df_spanish_names.dropna(subset=['number'])

# Truncate datasets to have 200 rows
df_usa_names = df_usa_names.head(200)
df_french_names = df_french_names.head(200)
df_spanish_names = df_spanish_names.head(200)

# Add ranks to each dataset
df_usa_names['Rank'] = df_usa_names['Population'].rank(ascending=False).astype(int)
df_french_names['Rank'] = df_french_names['Population'].rank(ascending=False).astype(int)
df_spanish_names['Rank'] = df_spanish_names['number'].rank(ascending=False).astype(int)

# Calculate the total population for each country
total_population_usa = df_usa_names['Population'].sum()
total_population_france = df_french_names['Population'].sum()
total_population_spain = df_spanish_names['number'].sum()

# Calculate the percentage of the total population for each rank
df_usa_names['percentage'] = (df_usa_names['Population'] / total_population_usa) * 100
df_french_names['percentage'] = (df_french_names['Population'] / total_population_france) * 100
df_spanish_names['percentage'] = (df_spanish_names['number'] / total_population_spain) * 100

# Calculate average percentages
avg_percentages = np.mean([df_usa_names['percentage'], df_french_names['percentage'], df_spanish_names['percentage']], axis=0)
df_avg_percentages = pd.DataFrame({'Rank': range(1, 201), 'Average Percentages': avg_percentages})

df_population = pd.read_csv('german_population.csv', delimiter=';')
df_names = pd.read_csv('names.csv')

# Map the 'Gender' column
gender_mapping = {'m': 'Male', 'f': 'Female'}
df_names['Gender'] = df_names['Gender'].map(gender_mapping)

# Melt the DataFrame to reshape it
melted_df = pd.melt(df_population, id_vars=['Year'], value_vars=['Male', 'Female'], var_name='Gender', value_name='Population')

# Function to clean population values and convert to integer
def clean_population(population):
    if isinstance(population, float):
        return int(population * 1000)
    return int(population.replace('.', ''))

# Clean the population column
melted_df['Population'] = melted_df['Population'].astype(int)

merged_df = pd.merge(melted_df, df_names, on=['Year', 'Gender'], how='inner')

# Sort the names DataFrame by 'Year' and 'Placement'
merged_df.sort_values(by=['Year', 'Gender', 'Placement'], inplace=True)

# Merge the Main dataset with an average precentages from Spain, USA, France
complete_df = pd.merge(merged_df, df_avg_percentages, left_on='Placement', right_on='Rank', how='left')
complete_df.drop(['Rank',], axis=1, inplace=True)

# Calculate approximate number of names depending on population
complete_df['Approximate Names'] = (complete_df['Population'] * complete_df['Average Percentages']) / 10

complete_df.to_csv('names_calculation.csv', index=False)
