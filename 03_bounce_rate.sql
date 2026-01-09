WITH session_page_count AS (
    SELECT
        session_id,
        COUNT(*) AS page_count
    FROM fact_pageviews
    GROUP BY session_id
)
SELECT
    COUNT(CASE WHEN page_count = 1 THEN 1 END) * 1.0
    / COUNT(*) AS bounce_rate
FROM session_page_count;