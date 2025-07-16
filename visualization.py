import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sqlalchemy import create_engine
import urllib.parse

# Step 1: Connect to MySQL
username = 'root'
password = 'sanjana123'
host = 'localhost'
port = '3306'
database = 'precisiononcology_db'
password_encoded = urllib.parse.quote_plus(password)
DATABASE_URL = f"mysql+mysqlconnector://{username}:{password_encoded}@{host}:{port}/{database}"
engine = create_engine(DATABASE_URL)

# Step 2: Query 1 – Histogram: Patient Age Distribution
query1 = "SELECT age FROM patient;" 
df_age = pd.read_sql(query1, engine)

plt.figure(figsize=(6,4))
plt.hist(df_age['age'], bins=10, color='skyblue', edgecolor='black')
plt.title("Histogram: Patient Age Distribution")
plt.xlabel("Age")
plt.ylabel("Count")
plt.grid(True)
plt.show()

# Step 3: Query 2 – Pie Chart: Classification
query2 = "SELECT classification, COUNT(*) as count FROM patient GROUP BY classification;"
df_class = pd.read_sql(query2, engine)

plt.figure(figsize=(5,5))
plt.pie(df_class['count'], labels=df_class['classification'], autopct='%1.1f%%', startangle=140)
plt.title("Pie Chart: Patient Classification")
plt.axis('equal')
plt.show()

# Step 4: Query 3 – Boxplot: Biomarker Levels by Cancer Type
query3 = "SELECT cancer_type, level FROM biomarkers;"
df_biomarker = pd.read_sql(query3, engine)

plt.figure(figsize=(8,5))
sns.boxplot(x='cancer_type', y='level', data=df_biomarker)
plt.title("Boxplot: Biomarker Levels by Cancer Type")
plt.xlabel("Cancer Type")
plt.ylabel("Biomarker Level")
plt.grid(True)
plt.show()
