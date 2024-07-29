import pandas as pd
import os 
dir_path = os.path.dirname(os.path.realpath(__file__))

def xlsx_to_csv(xlsx_path, output_dir):
    # Read the Excel file
    xls = pd.ExcelFile(xlsx_path)
    
    # Iterate through each sheet in the Excel file
    for sheet_name in xls.sheet_names:
        # Read the sheet into a DataFrame
        df = pd.read_excel(xls, sheet_name)
        
        # Define the output path for the CSV file
        csv_path = f"{output_dir}/{sheet_name}.csv"
        
        # Save the DataFrame to a CSV file
        df.to_csv(csv_path, index=False)


xlsx_path = dir_path + "/datasheet/production/production.xlsx"
output_dir = dir_path + "/datasheet/production"
xlsx_to_csv(xlsx_path, output_dir)