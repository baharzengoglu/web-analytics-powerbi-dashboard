-- Exit Rate hesaplama
-- Exit = kullanıcının session içindeki son sayfası

WITH last_page AS (
    SELECT
        session_id,
        MAX(page_order) AS last_page_order
    FROM fact_pageviews
    GROUP BY session_id
),

exit_pages AS (
    SELECT
        fp.session_id,
        fp.page_name,
        1 AS exit_flag
    FROM fact_pageviews fp
    JOIN last_page lp
        ON fp.session_id = lp.session_id
       AND fp.page_order = lp.last_page_order
)

SELECT
    page_name,
    COUNT(exit_flag) AS exit_count
FROM exit_pages
GROUP BY page_name
ORDER BY exit_count DESC;