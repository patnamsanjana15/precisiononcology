
# Precision Oncology Patient Data Analytics

This project is designed to manage and analyze clinical oncology data, including patient records, treatments, biomarkers, imaging, genetic data, and clinical trial outcomes. It provides a structured database schema, connection interface, and sample visualizations for data-driven insights.

## 📁 Project Structure

- `normalized_schema.sql` – SQL script to create a fully normalized schema for oncology data.
- `database_connect.py` – Python script to connect to a MySQL/PostgreSQL database and perform basic operations.
- `visualization.py` – Python script with sample visualizations for clinical outcomes, patient demographics, or treatment metrics.

## 🧠 Features

- Comprehensive relational schema for clinical oncology datasets.
- Integration of genetic, imaging, and lab test data.
- Connection-ready database interaction script.
- Data visualization support using matplotlib/seaborn.

## ⚙️ Technologies Used

- SQL (MySQL/PostgreSQL compatible)
- Python 3.x
- Pandas, Matplotlib/Seaborn (for visualization)
- SQLAlchemy / `mysql.connector` (depending on database)

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/oncology-data-analytics.git
cd oncology-data-analytics
```

### 2. Create the Database

Run the `normalized_schema.sql` file in your SQL server to create all tables.

### 3. Configure Database Connection

Edit `database_connect.py` and enter your database credentials:

```python
host = "localhost"
user = "your_username"
password = "your_password"
database = "oncology_db"
```

### 4. Run Visualizations

Make sure your database is populated with sample data, then:

```bash
python visualization.py
```

## 📊 Example Visualizations

- Survival rate analysis
- Distribution of cancer types by age and gender
- Biomarker effectiveness comparison

## 📄 License

This project is licensed under the MIT License.

---

## 🤝 Acknowledgments

Special thanks to medical datasets and academic resources that inspired this schema design.

---

## 🔗 Author

[LinkedIn](www.linkedin.com/in/sanjana-patnam-82a338347) | [GitHub](https://github.com/patnamsanjana15)
