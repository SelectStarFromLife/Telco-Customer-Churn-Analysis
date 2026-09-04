USE telco_churn_analysis;

SELECT
    contract_type,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY contract_type
ORDER BY churn_rate_percentage DESC;

SELECT
    tenure_group,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
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
    
    SELECT
    internet_service,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage,
    ROUND(AVG(monthly_charges), 2) AS average_monthly_charges
FROM telco_churn_clean
GROUP BY internet_service
ORDER BY churn_rate_percentage DESC;

SELECT
    payment_method,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY payment_method
ORDER BY churn_rate_percentage DESC;

SELECT
    monthly_charge_group,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(AVG(monthly_charges), 2) AS average_monthly_charges,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY monthly_charge_group
ORDER BY
    CASE monthly_charge_group
        WHEN 'Low' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'High' THEN 3
    END;
    
SELECT
    contract_type,
    SUM(churn_flag) AS churned_customers,

    ROUND(
        100.0 * SUM(churn_flag) /
        (SELECT SUM(churn_flag) FROM telco_churn_clean),
        2
    ) AS contribution_to_total_churn_percentage

FROM telco_churn_clean
GROUP BY contract_type
ORDER BY contribution_to_total_churn_percentage DESC;

