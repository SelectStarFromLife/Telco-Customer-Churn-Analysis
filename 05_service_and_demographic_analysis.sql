USE telco_churn_analysis;

SELECT
    gender,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY gender
ORDER BY churn_rate_percentage DESC;

SELECT
    CASE
        WHEN senior_citizen = 1 THEN 'Senior Citizen'
        ELSE 'Non-Senior Citizen'
    END AS senior_citizen_status,

    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,

    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage

FROM telco_churn_clean
GROUP BY senior_citizen
ORDER BY churn_rate_percentage DESC;

SELECT
    partner,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY partner
ORDER BY churn_rate_percentage DESC;

SELECT
    dependents,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY dependents
ORDER BY churn_rate_percentage DESC;

SELECT
    paperless_billing,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY paperless_billing
ORDER BY churn_rate_percentage DESC;

SELECT
    tech_support,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY tech_support
ORDER BY churn_rate_percentage DESC;

SELECT
    online_security,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY online_security
ORDER BY churn_rate_percentage DESC;

SELECT
    online_backup,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY online_backup
ORDER BY churn_rate_percentage DESC;

SELECT
    device_protection,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY device_protection
ORDER BY churn_rate_percentage DESC;

SELECT
    phone_service,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY phone_service
ORDER BY churn_rate_percentage DESC;

SELECT
    streaming_tv,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY streaming_tv
ORDER BY churn_rate_percentage DESC;

SELECT
    streaming_movies,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_clean
GROUP BY streaming_movies
ORDER BY churn_rate_percentage DESC;

