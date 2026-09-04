USE telco_churn_analysis;
SELECT DATABASE();
DESCRIBE telco_churn_raw;

SELECT COUNT(*) AS total_customers
FROM telco_churn_raw;

SELECT COUNT(DISTINCT customerID) AS unique_customers
FROM telco_churn_raw;

SELECT COUNT(*) AS blank_total_charges
FROM telco_churn_raw
WHERE TRIM(TotalCharges) = '';

SELECT
    customerID,
    tenure,
    MonthlyCharges,
    TotalCharges,
    Churn
FROM telco_churn_raw
WHERE TRIM(TotalCharges) = '';

CREATE TABLE IF NOT EXISTS telco_churn_clean (
    customer_id CHAR(10) PRIMARY KEY,
    gender VARCHAR(10) NOT NULL,
    senior_citizen TINYINT NOT NULL,
    partner VARCHAR(5) NOT NULL,
    dependents VARCHAR(5) NOT NULL,
    tenure SMALLINT NOT NULL,
    phone_service VARCHAR(5) NOT NULL,
    multiple_lines VARCHAR(25) NOT NULL,
    internet_service VARCHAR(20) NOT NULL,
    online_security VARCHAR(25) NOT NULL,
    online_backup VARCHAR(25) NOT NULL,
    device_protection VARCHAR(25) NOT NULL,
    tech_support VARCHAR(25) NOT NULL,
    streaming_tv VARCHAR(25) NOT NULL,
    streaming_movies VARCHAR(25) NOT NULL,
    contract_type VARCHAR(20) NOT NULL,
    paperless_billing VARCHAR(5) NOT NULL,
    payment_method VARCHAR(35) NOT NULL,
    monthly_charges DECIMAL(10,2) NOT NULL,
    total_charges DECIMAL(10,2) NOT NULL,
    churn VARCHAR(5) NOT NULL,
    churn_flag TINYINT NOT NULL,
    customer_status VARCHAR(10) NOT NULL,
    tenure_group VARCHAR(25) NOT NULL,
    monthly_charge_group VARCHAR(20) NOT NULL
);

INSERT INTO telco_churn_clean (
    customer_id,
    gender,
    senior_citizen,
    partner,
    dependents,
    tenure,
    phone_service,
    multiple_lines,
    internet_service,
    online_security,
    online_backup,
    device_protection,
    tech_support,
    streaming_tv,
    streaming_movies,
    contract_type,
    paperless_billing,
    payment_method,
    monthly_charges,
    total_charges,
    churn,
    churn_flag,
    customer_status,
    tenure_group,
    monthly_charge_group
)
SELECT
    TRIM(customerID) AS customer_id,
    TRIM(gender) AS gender,
    SeniorCitizen AS senior_citizen,
    TRIM(Partner) AS partner,
    TRIM(Dependents) AS dependents,
    tenure,
    TRIM(PhoneService) AS phone_service,
    TRIM(MultipleLines) AS multiple_lines,
    TRIM(InternetService) AS internet_service,
    TRIM(OnlineSecurity) AS online_security,
    TRIM(OnlineBackup) AS online_backup,
    TRIM(DeviceProtection) AS device_protection,
    TRIM(TechSupport) AS tech_support,
    TRIM(StreamingTV) AS streaming_tv,
    TRIM(StreamingMovies) AS streaming_movies,
    TRIM(Contract) AS contract_type,
    TRIM(PaperlessBilling) AS paperless_billing,
    TRIM(PaymentMethod) AS payment_method,
    MonthlyCharges AS monthly_charges,

    COALESCE(
        CAST(NULLIF(TRIM(TotalCharges), '') AS DECIMAL(10,2)),
        0
    ) AS total_charges,

    TRIM(Churn) AS churn,

    CASE
        WHEN TRIM(Churn) = 'Yes' THEN 1
        ELSE 0
    END AS churn_flag,

    CASE
        WHEN TRIM(Churn) = 'Yes' THEN 'Churned'
        ELSE 'Retained'
    END AS customer_status,

    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        WHEN tenure <= 60 THEN '49-60 Months'
        ELSE '61-72 Months'
    END AS tenure_group,

    CASE
        WHEN MonthlyCharges < 35 THEN 'Low'
        WHEN MonthlyCharges < 70 THEN 'Medium'
        ELSE 'High'
    END AS monthly_charge_group

FROM telco_churn_raw;

SELECT COUNT(*) AS cleaned_customers
FROM telco_churn_clean;

SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM telco_churn_clean;

SELECT
    customer_id,
    COUNT(*) AS occurrence_count
FROM telco_churn_clean
GROUP BY customer_id
HAVING COUNT(*) > 1;

DESCRIBE telco_churn_clean;

SELECT
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(tenure IS NULL) AS null_tenure,
    SUM(monthly_charges IS NULL) AS null_monthly_charges,
    SUM(total_charges IS NULL) AS null_total_charges,
    SUM(churn IS NULL) AS null_churn
FROM telco_churn_clean;

SELECT COUNT(*) AS zero_total_charges
FROM telco_churn_clean
WHERE total_charges = 0;

SELECT
    customer_id,
    tenure,
    monthly_charges,
    total_charges,
    churn
FROM telco_churn_clean
WHERE total_charges = 0;

SELECT
    customer_status,
    churn_flag,
    COUNT(*) AS customer_count
FROM telco_churn_clean
GROUP BY customer_status, churn_flag;

SELECT
    tenure_group,
    COUNT(*) AS customer_count
FROM telco_churn_clean
GROUP BY tenure_group
ORDER BY
    CASE tenure_group
        WHEN '0-12 Months' THEN 1
        WHEN '13-24 Months' THEN 2
        WHEN '25-48 Months' THEN 3
        WHEN '49-60 Months' THEN 4
        WHEN '61-72 Months' THEN 5
    END;

SELECT *
FROM telco_churn_clean
LIMIT 10;    