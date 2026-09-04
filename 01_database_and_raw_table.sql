CREATE DATABASE IF NOT EXISTS telco_churn_analysis;
USE telco_churn_analysis;
SELECT DATABASE();

CREATE TABLE IF NOT EXISTS telco_churn_raw (
    customerID VARCHAR(20),
    gender VARCHAR(10),
    SeniorCitizen TINYINT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure SMALLINT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(25),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(25),
    OnlineBackup VARCHAR(25),
    DeviceProtection VARCHAR(25),
    TechSupport VARCHAR(25),
    StreamingTV VARCHAR(25),
    StreamingMovies VARCHAR(25),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(35),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges VARCHAR(20),
    Churn VARCHAR(5)
);

SELECT COUNT(*) AS total_rows
FROM telco_churn_raw;

SELECT *
FROM telco_churn_raw
LIMIT 10;

SELECT COUNT(DISTINCT customerID) AS Customer_Count
FROM telco_churn_raw;

SELECT
    customerID,
    COUNT(*) AS occurrence_count
FROM telco_churn_raw
GROUP BY customerID
HAVING COUNT(*) > 1;

SELECT Churn, COUNT(*) AS customer_count
FROM telco_churn_raw
GROUP BY Churn;

SELECT
    customerID,
    tenure,
    MonthlyCharges,
    TotalCharges,
    Churn
FROM telco_churn_raw
WHERE TRIM(TotalCharges) = '';

SELECT
    COUNT(*) AS blank_total_charges
FROM telco_churn_raw
WHERE TRIM(TotalCharges) = '';

SELECT COUNT(*) AS missing_custonerID
FROM telco_churn_raw
WHERE customerID IS NULL
OR TRIM(customerID) = '';

SELECT DISTINCT SeniorCitizen
FROM telco_churn_raw;

SELECT
MIN(tenure) AS Minimun_Tenure,
MAX(tenure) AS Maximum_Tenure,
AVG(tenure) AS Average_Tenure
FROM telco_churn_raw;

SELECT
MIN(MonthlyCharges) AS Minimum_Monthly_Charges,
MAX(MonthlyCharges) AS Maximum_Monthly_Charges,
AVG(MonthlyCharges) AS Average_Monthly_Charges
FROM telco_churn_raw;