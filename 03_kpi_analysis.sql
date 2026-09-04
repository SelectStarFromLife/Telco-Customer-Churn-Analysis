USE telco_churn_analysis;

SELECT COUNT(*) AS total_records
FROM telco_churn_clean;

SELECT
    COUNT(*) AS total_customers,

    SUM(churn_flag) AS churned_customers,

    COUNT(*) - SUM(churn_flag) AS retained_customers,

    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage,

    ROUND(
        100.0 * (COUNT(*) - SUM(churn_flag)) / COUNT(*),
        2
    ) AS retention_rate_percentage

FROM telco_churn_clean;

SELECT
    ROUND(AVG(tenure), 2) AS average_tenure_months,

    ROUND(AVG(monthly_charges), 2) AS average_monthly_charges,

    ROUND(AVG(total_charges), 2) AS average_total_charges,

    ROUND(SUM(monthly_charges), 2) AS current_monthly_charges,

    ROUND(SUM(total_charges), 2) AS total_historical_charges

FROM telco_churn_clean;

SELECT
    ROUND(
        SUM(
            CASE
                WHEN churn_flag = 1 THEN monthly_charges
                ELSE 0
            END
        ),
        2
    ) AS monthly_revenue_at_risk
FROM telco_churn_clean;

SELECT
    customer_status,
    COUNT(*) AS customer_count,

    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM telco_churn_clean),
        2
    ) AS percentage_of_customers,

    ROUND(AVG(tenure), 2) AS average_tenure,

    ROUND(AVG(monthly_charges), 2) AS average_monthly_charges,

    ROUND(AVG(total_charges), 2) AS average_total_charges,

    ROUND(SUM(monthly_charges), 2) AS total_monthly_charges

FROM telco_churn_clean

GROUP BY customer_status

ORDER BY customer_count DESC;

SELECT
    COUNT(*) AS total_customers,

    SUM(churn_flag) AS churned_customers,

    COUNT(*) - SUM(churn_flag) AS retained_customers,

    ROUND(100.0 * AVG(churn_flag), 2) AS churn_rate_percentage,

    ROUND(100.0 * (1 - AVG(churn_flag)), 2)
        AS retention_rate_percentage,

    ROUND(AVG(tenure), 2) AS average_tenure_months,

    ROUND(AVG(monthly_charges), 2)
        AS average_monthly_charges,

    ROUND(SUM(monthly_charges), 2)
        AS current_monthly_charges,

    ROUND(
        SUM(
            CASE
                WHEN churn_flag = 1 THEN monthly_charges
                ELSE 0
            END
        ),
        2
    ) AS monthly_revenue_at_risk

FROM telco_churn_clean;

