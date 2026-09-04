USE telco_churn_analysis;

-- Dashboard headline KPIs

SELECT
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,

    ROUND(
        100.0 * AVG(churn_flag),
        2
    ) AS churn_rate_percentage,

    ROUND(
        100.0 * (1 - AVG(churn_flag)),
        2
    ) AS retention_rate_percentage,

    ROUND(
        AVG(tenure),
        2
    ) AS average_tenure_months,

    ROUND(
        AVG(monthly_charges),
        2
    ) AS average_monthly_charges,

    ROUND(
        SUM(monthly_charges),
        2
    ) AS total_monthly_charges,

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

-- Churn analysis by contract type

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

-- Churn analysis by tenure group

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
    
-- Churn analysis by internet service

SELECT
    internet_service,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,

    ROUND(
        AVG(monthly_charges),
        2
    ) AS average_monthly_charges,

    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage

FROM telco_churn_clean
GROUP BY internet_service
ORDER BY churn_rate_percentage DESC;

-- Churn analysis by payment method

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

-- Churn analysis by monthly-charge group

SELECT
    monthly_charge_group,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,

    ROUND(
        AVG(monthly_charges),
        2
    ) AS average_monthly_charges,

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
    
-- Churn analysis by technical-support status

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

-- Churn analysis by online-security status

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

-- Churn analysis by senior-citizen status

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
    contract_type,
    tenure_group,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,

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

    ROUND(
        100.0 * SUM(churn_flag) / COUNT(*),
        2
    ) AS churn_rate_percentage

FROM telco_churn_clean

GROUP BY
    contract_type,
    internet_service

ORDER BY churn_rate_percentage DESC;