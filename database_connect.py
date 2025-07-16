import pandas as pd
from sqlalchemy import create_engine
import urllib.parse
import os

username = 'root'
password = 'sanjana123'
host = 'localhost'
port = '3306'
database = 'precisiononcology_db'
password_encoded = urllib.parse.quote_plus(password)
DATABASE_URL = f"mysql+mysqlconnector://{username}:{password_encoded}@{host}:{port}/{database}"
engine = create_engine(DATABASE_URL)

csv_base_path = "/Users/sanjanapatnam/Desktop/precision_oncology"

csv_files = {
    'patient': os.path.join(csv_base_path, 'patient.csv'),
    'oncologist': os.path.join(csv_base_path, 'oncologist.csv'),
    'treatment': os.path.join(csv_base_path, 'treatment.csv'),
    'clinical_trials': os.path.join(csv_base_path, 'clinical_trials.csv'),
    'medical_imaging': os.path.join(csv_base_path, 'medical_imaging.csv'),
    'genetic_data': os.path.join(csv_base_path, 'genetic_data.csv'),
    'histopathological_data': os.path.join(csv_base_path, 'histopathological_data.csv'),
    'biomarker_type': os.path.join(csv_base_path, 'biomarker_type.csv'),
    'biomarkers': os.path.join(csv_base_path, 'biomarkers.csv'),
    'lab_test': os.path.join(csv_base_path, 'lab_test.csv'),
    'outcome': os.path.join(csv_base_path, 'outcome.csv'),
    'health_condition': os.path.join(csv_base_path, 'health_condition.csv'),
    'treatment_oncologist': os.path.join(csv_base_path, 'treatment_oncologist.csv'),
    'patient_clinical_trial': os.path.join(csv_base_path, 'patient_clinical_trial.csv'),
    'treatment_clinical_trial': os.path.join(csv_base_path, 'treatment_clinical_trial.csv'),
}

insert_order = [
    'patient',
    'oncologist',
    'treatment',
    'clinical_trials',
    'medical_imaging',
    'genetic_data',
    'histopathological_data',
    'biomarker_type',
    'biomarkers',
    'lab_test',
    'outcome',
    'health_condition',
    'treatment_oncologist',
    'patient_clinical_trial',
    'treatment_clinical_trial',
]

for table_name in insert_order:
    csv_file = csv_files.get(table_name)
    if not csv_file or not os.path.exists(csv_file):
        print(f"⚠️ File not found for table '{table_name}': {csv_file}")
        continue
    try:
        df = pd.read_csv(csv_file)
        for col in df.columns:
            if 'date' in col.lower():
                df[col] = pd.to_datetime(df[col], errors='coerce')
        df.replace('', None, inplace=True)
        df.to_sql(table_name, con=engine, if_exists='append', index=False)
        print(f"✅ Inserted {len(df)} rows into '{table_name}'")
    except Exception as e:
        print(f"❌ Error inserting into '{table_name}': {e}")

#Open your terminal and run this if you haven't installed the package:
#pip install pandas sqlalchemy mysql-connector-python
 #cd ~/Desktop/precision_oncology
#python database_connect.py       

