import pandas as pd
import numpy as np

df_population = pd.read_csv('german_population.csv', delimiter=';')
df_names = pd.read_csv('names.csv')

# Define a dictionary to map gender codes to their respective genders
gender_mapping = {'m': 'Male', 'f': 'Female'}

# Map the 'Gender' column in the names DataFrame to the full gender names
df_names['Gender'] = df_names['Gender'].map(gender_mapping)

# Melt the DataFrame to reshape it
melted_df = pd.melt(df_population, id_vars=['Year'], value_vars=['Male', 'Female'], var_name='Gender', value_name='Population')

# Function to clean population values and convert to integer
def clean_population(population):
    if isinstance(population, float):
        return int(population * 1000)  # Multiply by 1000 to convert from float to integer
    return int(population.replace('.', ''))

# Clean the population column
melted_df['Population'] = melted_df['Population'].apply(clean_population)

merged_df = pd.merge(melted_df, df_names, on=['Year', 'Gender'], how='inner')

# Sort the names DataFrame by 'Year' and 'Placement'
merged_df.sort_values(by=['Year', 'Gender', 'Placement'], inplace=True)

def hyperbolic_coefficients(max_placement, majority_coefficient=0.4):
    coefficients = [majority_coefficient / rank for rank in range(1, max_placement + 1)]
    return coefficients

# Determine the maximum placement in the dataset
max_placement = min(merged_df['Placement'].max(), 25)  # Limit to 25 for hyperbolic calculation

# Calculate coefficients using hyperbolic function
coefficients = hyperbolic_coefficients(max_placement)

# Function to calculate approximate number of names based on placement and coefficients
def calculate_approx_names(row):
    total_population = row['Population']
    placement = row['Placement']
    coefficient = coefficients[placement - 1] if placement <= 25 else 0.012
    return round(total_population * coefficient, 2)

# Apply the function to calculate approximate names and create a new column
merged_df['Approx_Names'] = merged_df.apply(calculate_approx_names, axis=1)

# Save the DataFrame to a new CSV file
merged_df.to_csv('names_calculation.csv', index=False)

print(merged_df.head())

