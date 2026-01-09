WITH funnel AS (
    SELECT
        session_id,
        MAX(CASE WHEN page_name = 'Home' THEN 1 ELSE 0 END) AS step1,
        MAX(CASE WHEN page_name = 'Product' THEN 1 ELSE 0 END) AS step2,
        MAX(CASE WHEN page_name = 'Checkout' THEN 1 ELSE 0 END) AS step3
    FROM fact_pageviews
    GROUP BY session_id
)
SELECT
    SUM(step1) AS step1_sessions,
    SUM(CASE WHEN step1 = 1 AND step2 = 1 THEN 1 ELSE 0 END) AS step2_sessions,
    SUM(CASE WHEN step2 = 1 AND step3 = 1 THEN 1 ELSE 0 END) AS step3_sessions
FROM funnel;