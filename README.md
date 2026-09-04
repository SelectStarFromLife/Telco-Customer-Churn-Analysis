# Telecom Customer Churn & Retention Analysis

## Project Overview

This project analyzes customer churn for a fictional telecommunications company. The objective is to identify the customer groups most likely to leave, measure the revenue exposed to churn, and recommend practical retention actions.

MySQL was used to import, clean, transform, and analyze the customer data. The analytical results were exported to Google Sheets, where an executive dashboard was created to communicate the most important KPIs, churn drivers, business insights, and recommendations.

![Telecom Customer Churn Dashboard](Screenshots/01_dashboard_overview.png)

## Business Problem

Customer churn directly affects recurring revenue and customer-acquisition costs. Management needs to understand:

- What are the overall churn and retention rates?
- How much monthly revenue is associated with churned customers?
- Which contract types have the highest churn?
- How does customer tenure influence churn?
- Which internet services and payment methods are associated with higher churn?
- Does access to technical support affect customer retention?
- Are senior citizens more likely to churn?
- Which customer segments should receive priority retention attention?

## Project Objectives

- Create a structured MySQL database from the raw CSV file.
- Clean inconsistent and blank values without changing the source data.
- Build an analysis-ready customer table.
- Calculate customer, churn, retention, tenure, charge, and revenue KPIs.
- Diagnose churn across contract, tenure, service, payment, support, and demographic segments.
- Export SQL results for reporting.
- Build a one-page Google Sheets dashboard.
- Translate the analysis into business insights and retention recommendations.

## Dataset

The project uses the [Telco Customer Churn dataset](https://www.kaggle.com/datasets/blastchar/telco-customer-churn), which contains one record per customer and information about:

- Customer demographics
- Account tenure
- Phone and internet services
- Online security and technical support
- Contract and billing preferences
- Monthly and total charges
- Customer churn status

### Dataset summary

| Item | Value |
|---|---:|
| Customer records | 7,043 |
| Original columns | 21 |
| Churned customers | 1,869 |
| Retained customers | 5,174 |

The dataset represents a fictional company and is intended for analytical and educational use.

## Tools and Technologies

- **MySQL Server 8.0** — database storage and SQL analysis
- **MySQL Workbench 8.0** — importing data, developing queries, and exporting results
- **Google Sheets** — KPI presentation, charts, formatting, filters, and dashboard development
- **Microsoft Excel (.xlsx)** — offline dashboard copy
- **GitHub** — project documentation and portfolio presentation

## Project Workflow

```text
Raw CSV
   ↓
MySQL database and raw table
   ↓
Data-quality assessment
   ↓
Clean analytical table
   ↓
KPI and churn-driver analysis
   ↓
CSV result exports
   ↓
Google Sheets dashboard
   ↓
Business insights and recommendations
```

## Repository Structure

```text
telco_customer_churn_analysis/
│
├── Raw_Data/
│   └── WA_Fn-UseC_-Telco-Customer-Churn.csv
│
├── SQL_script/
│   ├── 01_database_and_raw_table.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_kpi_analysis.sql
│   ├── 04_churn_diagnostic_analysis.sql
│   ├── 05_service_and_demographic_analysis.sql
│   ├── 06_advanced_customer_segmentation.sql
│   └── 07_dashboard_output_queries.sql
│
├── SQL_outputs/
│   └── CSV files used for dashboard development
│
├── Google_Sheets_Dashboard/
│   └── Telecom_Customer_Churn_Dashboard.xlsx
│
├── Screenshots/
│   ├── 01_dashboard_overview.png
│   ├── 02a_sql_data_cleaning.png
│   ├── 02b_sql_customer_segmentation.png
│   ├── 03_sql_kpi_analysis.png
│   ├── 04_churn_by_contract.png
│   ├── 05_combined_segment_analysis.png
│   └── 06_clean_data_preview.png
│
├── Project_Documentation/
└── README.md
```

## Data Preparation and Cleaning

The original CSV was imported into `telco_churn_raw`. A separate table named `telco_churn_clean` was created so that the raw data remained unchanged.

The main cleaning and transformation steps were:

- Removed unnecessary leading and trailing spaces using `TRIM()`.
- Converted blank `TotalCharges` values into usable numeric values.
- Converted `TotalCharges` from text to `DECIMAL(10,2)`.
- Created `churn_flag`, where churned customers equal `1` and retained customers equal `0`.
- Created readable customer-status labels: `Churned` and `Retained`.
- Grouped customers into tenure bands.
- Grouped customers into monthly-charge bands.
- Preserved the raw table for traceability and validation.

Example transformation:

```sql
COALESCE(
    CAST(NULLIF(TRIM(TotalCharges), '') AS DECIMAL(10,2)),
    0
) AS total_charges
```

![SQL Data Cleaning](Screenshots/02a_sql_data_cleaning.png)

![SQL Customer Segmentation](Screenshots/02b_sql_customer_segmentation.png)

## Key Performance Indicators

| KPI | Result |
|---|---:|
| Total customers | 7,043 |
| Churned customers | 1,869 |
| Retained customers | 5,174 |
| Churn rate | 26.54% |
| Retention rate | 73.46% |
| Average tenure | 32.37 months |
| Average monthly charges | $64.76 |
| Monthly revenue at risk | $139,130.85 |

![SQL KPI Analysis](Screenshots/03_sql_kpi_analysis.png)

## SQL Analysis

The project uses:

- `SELECT`, `WHERE`, and `ORDER BY`
- Aggregate functions including `COUNT()`, `SUM()`, and `AVG()`
- `GROUP BY`
- Conditional logic using `CASE`
- Data cleaning using `TRIM()`, `NULLIF()`, `CAST()`, and `COALESCE()`
- Percentage and revenue calculations
- Multi-dimensional customer segmentation

### Example: churn by contract type

```sql
SELECT
    contract_type,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    COUNT(*) - SUM(churn_flag) AS retained_customers,
    ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate
FROM telco_churn_clean
GROUP BY contract_type
ORDER BY churn_rate DESC;
```

![Churn by Contract Type](Screenshots/04_churn_by_contract.png)

### Combined customer-segment analysis

Customers were also analyzed using combinations of attributes. The combination of a **month-to-month contract and fiber-optic internet service** recorded a churn rate of approximately **54.61%**, making it an important high-risk segment.

![Combined Segment Analysis](Screenshots/05_combined_segment_analysis.png)

## Dashboard

The Google Sheets dashboard contains:

- Eight KPI cards
- Churn rate by contract type
- Churn rate by tenure group
- Churn rate by internet service
- Churn rate by payment method
- Churn rate by technical-support status
- Churn rate by senior-citizen status
- Key business insights
- Retention recommendations

The dashboard was designed as a concise executive view so that decision-makers can quickly identify priority churn segments.

![Clean Data Preview](Screenshots/06_clean_data_preview.png)

## Key Business Insights

1. The overall customer churn rate is **26.54%**, representing **1,869 customers**.
2. Customers on month-to-month contracts have a **42.71%** churn rate, compared with only **2.83%** for two-year contracts.
3. Customers within their first 12 months have the highest tenure-based churn rate at **47.44%**.
4. Fiber-optic customers have a **41.89%** churn rate and require further pricing, reliability, and service-quality investigation.
5. Customers paying through electronic check have the highest payment-method churn rate at **45.29%**.
6. Customers without technical support have a **41.64%** churn rate.
7. Senior citizens have a **41.68%** churn rate, compared with **23.61%** for non-senior customers.
8. Churned customers represent approximately **$139,130.85 in monthly revenue at risk**.

## Business Recommendations

- Strengthen onboarding and engagement programs during customers' first 12 months.
- Offer suitable incentives for month-to-month customers to move to one-year or two-year contracts.
- Investigate fiber-optic pricing, reliability, service quality, and customer-support experiences.
- Encourage electronic-check customers to adopt automatic bank-transfer or credit-card payments.
- Bundle technical support and online security with suitable high-value internet plans.
- Provide simplified billing communication and targeted assistance for senior customers.
- Prioritize retention campaigns for customers who combine several high-risk characteristics.

## How to Use This Project

1. Download or clone the repository.
2. Open MySQL Workbench and connect to MySQL Server.
3. Run the scripts in `SQL_script` in numerical order.
4. Review the exported analysis files in `SQL_outputs`.
5. Open `Telecom_Customer_Churn_Dashboard.xlsx` from `Google_Sheets_Dashboard`.
6. Review the dashboard, insights, and business recommendations.

## Project Limitations

- The dataset is fictional and does not represent a real telecom company.
- The data provides customer status at a single point in time, so a true monthly churn trend cannot be calculated.
- Monthly revenue at risk is an estimate based on the monthly charges of customers marked as churned; it is not confirmed realized revenue loss.
- The analysis identifies associations with churn but does not prove that any individual characteristic directly causes churn.

## Future Enhancements

- Build a churn-prediction model using Python.
- Add customer-lifetime-value analysis.
- Create a formal churn-risk score for individual customers.
- Add time-series analysis if historical customer records become available.
- Rebuild the reporting layer in Power BI for more advanced interaction.

## Author

**Argha Saha**  
Aspiring Data Analyst  

Skills demonstrated: SQL, MySQL, Google Sheets, data cleaning, customer analytics, KPI development, data visualization, dashboard development, and business analysis.

