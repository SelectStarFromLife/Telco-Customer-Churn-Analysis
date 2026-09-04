USE telco_churn_analysis;

SELECT
    contract_type,
    tenure_group,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY
    contract_type,
    tenure_group
ORDER BY churn_rate_percentage DESC;

SELECT
    contract_type,
    internet_service,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,

    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(monthly_charges),
        2
    ) AS average_monthly_charges

FROM telco_churn_clean

GROUP BY
    contract_type,
    internet_service

ORDER BY churn_rate_percentage DESC;