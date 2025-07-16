
CREATE TABLE PATIENT (
  patient_id VARCHAR(10) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  age INT NOT NULL,
  gender VARCHAR(10) NOT NULL,
  contact_info TEXT,
  diagnosis_date DATE,
  classification VARCHAR(20) CHECK (classification IN ('Adult', 'Pediatric')) NOT NULL
);

CREATE TABLE HEALTH_CONDITION (
  condition_id VARCHAR(10) PRIMARY KEY,
  patient_id VARCHAR(10) NOT NULL,
  condition_description TEXT,
  diagnosis_date DATE,
  FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
);

CREATE TABLE ONCOLOGIST (
  oncologist_id VARCHAR(10) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  specialization VARCHAR(100),
  hospital_affiliation VARCHAR(255)
);

CREATE TABLE TREATMENT (
  treatment_id VARCHAR(10) PRIMARY KEY,
  patient_id VARCHAR(10) NOT NULL,
  start_date DATE,
  end_date DATE,
  status VARCHAR(50),
  FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
);

CREATE TABLE TREATMENT_ONCOLOGIST (
  treatment_id VARCHAR(10),
  oncologist_id VARCHAR(10),
  PRIMARY KEY (treatment_id, oncologist_id),
  FOREIGN KEY (treatment_id) REFERENCES TREATMENT(treatment_id),
  FOREIGN KEY (oncologist_id) REFERENCES ONCOLOGIST(oncologist_id)
);

CREATE TABLE OUTCOME (
  outcome_id VARCHAR(10) PRIMARY KEY,
  treatment_id VARCHAR(10) UNIQUE NOT NULL,
  trial_id VARCHAR(10) NOT NULL,
  survival_rate DECIMAL(5,2),
  side_effects TEXT,
  effectiveness VARCHAR(50),
  FOREIGN KEY (treatment_id) REFERENCES TREATMENT(treatment_id),
  FOREIGN KEY (trial_id) REFERENCES CLINICAL_TRIALS(trial_id)
);

CREATE TABLE GENETIC_DATA (
  genomic_id VARCHAR(10) PRIMARY KEY,
  patient_id VARCHAR(10) NOT NULL,
  mutation VARCHAR(100),
  sequence_data TEXT,
  FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
);

CREATE TABLE CLINICAL_TRIALS (
  trial_id VARCHAR(10) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  phase VARCHAR(50),
  eligibility_criteria TEXT
);

CREATE TABLE PATIENT_CLINICAL_TRIAL (
  patient_id VARCHAR(10),
  trial_id VARCHAR(10),
  PRIMARY KEY (patient_id, trial_id),
  FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id),
  FOREIGN KEY (trial_id) REFERENCES CLINICAL_TRIALS(trial_id)
);

CREATE TABLE TREATMENT_CLINICAL_TRIAL (
  treatment_id VARCHAR(10),
  trial_id VARCHAR(10),
  PRIMARY KEY (treatment_id, trial_id),
  FOREIGN KEY (treatment_id) REFERENCES TREATMENT(treatment_id),
  FOREIGN KEY (trial_id) REFERENCES CLINICAL_TRIALS(trial_id)
);

CREATE TABLE MEDICAL_IMAGING (
  image_id VARCHAR(10) PRIMARY KEY,
  patient_id VARCHAR(10) NOT NULL,
  image_type VARCHAR(50),
  image_size VARCHAR(50),
  texture VARCHAR(50),
  intensity VARCHAR(50),
  findings TEXT,
  FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
);

CREATE TABLE HISTOPATHOLOGICAL_DATA (
  histopath_id VARCHAR(10) PRIMARY KEY,
  patient_id VARCHAR(10) NOT NULL,
  pathological_findings TEXT,
  diagnosis VARCHAR(255),
  FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
);

CREATE TABLE LAB_TEST (
  test_id VARCHAR(10) PRIMARY KEY,
  patient_id VARCHAR(10) NOT NULL,
  test_type VARCHAR(50),
  test_results TEXT,
  FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
);

CREATE TABLE BIOMARKER_TYPE (
  biomarker_type_id VARCHAR(10) PRIMARY KEY,
  type_name VARCHAR(100),
  description TEXT
);

CREATE TABLE BIOMARKERS (
  biomarker_id VARCHAR(10) PRIMARY KEY,
  patient_id VARCHAR(10) NOT NULL,
  biomarker_type_id VARCHAR(10) NOT NULL,
  name VARCHAR(100),
  level DECIMAL(5,2),
  cancer_type VARCHAR(50),
  predictive_value DECIMAL(5,2),
  FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id),
  FOREIGN KEY (biomarker_type_id) REFERENCES BIOMARKER_TYPE(biomarker_type_id)
);

CREATE TABLE TREATMENT_BIOMARKER (
  treatment_id VARCHAR(10),
  biomarker_id VARCHAR(10),
  PRIMARY KEY (treatment_id, biomarker_id),
  FOREIGN KEY (treatment_id) REFERENCES TREATMENT(treatment_id),
  FOREIGN KEY (biomarker_id) REFERENCES BIOMARKERS(biomarker_id)
);
