-- List names and classifications of pediatric patients
SELECT name, classification 
FROM PATIENT 
WHERE classification = 'Pediatric';

#Aggregate Query
-- Count the number of patients by classification
SELECT classification, COUNT(*) AS total_patients
FROM PATIENT
GROUP BY classification;

#Inner Join (Tables: TREATMENT, PATIENT)
-- List treatment status along with corresponding patient names
SELECT t.treatment_id, p.name, t.status
FROM TREATMENT t
JOIN PATIENT p ON t.patient_id = p.patient_id;


#Outer Join (LEFT JOIN)
-- List all patients and their treatment status if available
SELECT p.name, t.status
FROM PATIENT p
LEFT JOIN TREATMENT t ON p.patient_id = t.patient_id;

#Nested Query (Table: MEDICAL_IMAGING)
-- Get names of patients who had CT scans
SELECT name
FROM PATIENT
WHERE patient_id IN (
    SELECT patient_id
    FROM MEDICAL_IMAGING
    WHERE image_type = 'CT'
);

#Correlated Query #2
#Tables used: ONCOLOGIST, TREATMENT_ONCOLOGIST, TREATMENT
-- List oncologists who are assigned to more than one treatment
SELECT o.name
FROM ONCOLOGIST o
WHERE (
    SELECT COUNT(*)
    FROM TREATMENT_ONCOLOGIST to2
    WHERE to2.oncologist_id = o.oncologist_id
) > 1;

#EXISTS (Tables: PATIENT, GENETIC_DATA)
-- List patients who have at least one genetic mutation record
SELECT name
FROM PATIENT p
WHERE EXISTS (
    SELECT 1
    FROM GENETIC_DATA g
    WHERE g.patient_id = p.patient_id
);

#Set Operation (UNION) #2
#Tables used: GENETIC_DATA, BIOMARKERS
-- List patient IDs who have either genetic data or biomarker entries
SELECT DISTINCT patient_id FROM GENETIC_DATA
UNION
SELECT DISTINCT patient_id FROM BIOMARKERS;


#Subquery in SELECT Clause (Tables: PATIENT, BIOMARKERS)
-- Show patient name and number of biomarkers they have
SELECT p.name,
       (SELECT COUNT(*)
        FROM BIOMARKERS b
        WHERE b.patient_id = p.patient_id) AS biomarker_count
FROM PATIENT p;

#Subquery in FROM Clause (Tables: OUTCOME, CLINICAL_TRIALS)
-- Get average survival rate by trial phase
SELECT c.phase, AVG(o.survival_rate) AS avg_survival
FROM OUTCOME o
JOIN (
    SELECT trial_id, phase
    FROM CLINICAL_TRIALS
) c ON o.trial_id = c.trial_id
GROUP BY c.phase;

#Complex Query:
#"List all patients who have taken more than 1 lab test and show their total test 
#count along with their most recent test type."

SELECT 
    p.patient_id,
    p.name,
    COUNT(l.test_id) AS total_tests,
    MAX(l.test_type) AS latest_test_type
FROM 
    PATIENT p
JOIN 
    LAB_TEST l ON p.patient_id = l.patient_id
GROUP BY 
    p.patient_id, p.name
HAVING 
    COUNT(l.test_id) > 1;

#JOIN: PATIENT is joined with LAB_TEST on patient_id
#Aggregation: COUNT() counts lab tests per patient; MAX() fetches the latest test type (assuming it's alphabetical or temporal)
#Grouping: Grouped by each patient
#Filtering: HAVING COUNT(...) > 1 restricts to patients with more than 1 test










