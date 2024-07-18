--- Calculating two or more rows by using ARRAY Function ----
CREATE OR REPLACE FUNCTION calculate_ANYproduct_profit(product_ids_input VARCHAR[])
RETURNS TABLE (
    product_id VARCHAR,
    total_sales NUMERIC,
    total_profit NUMERIC,
    profit_percentage NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        s.product_id AS product_id,
        SUM(s.sales)::NUMERIC AS total_sales,
        SUM(s.profit)::NUMERIC AS total_profit,
        CASE 
            WHEN SUM(s.sales) = 0 THEN 0
            ELSE ROUND((SUM(s.profit) / SUM(s.sales))::NUMERIC * 100, 2)  -- Round to 2 decimal places
        END AS profit_percentage
    FROM
        sales s
    WHERE  
        s.product_id = ANY(product_ids_input)
    GROUP BY
        s.product_id;
END;
$$ LANGUAGE plpgsql;




--Executing---
SELECT product_id, total_sales, total_profit, profit_percentage
FROM calculate_ANYproduct_profit (ARRAY['OFF-AR-10002833',
'TEC-PH-10002275',
'OFF-BI-10003910',
'OFF-AP-10002892',
'FUR-TA-10001539',
'TEC-PH-10002033',
'OFF-PA-10002365',
'OFF-BI-10003656',
'OFF-AP-10002311',
'OFF-BI-10000756']);


select * from sales
