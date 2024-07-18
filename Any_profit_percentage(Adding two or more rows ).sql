--- Calculating two or more rows by using ARRAY Function ----

CREATE OR REPLACE FUNCTION calculate_ANYproduct_profit(product_id_input VARCHAR[])
RETURNS TABLE (
    product_id VARCHAR,  
    total_sales DOUBLE PRECISION,
    total_profit DOUBLE PRECISION,
    profit_percentage DOUBLE PRECISION
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        s.product_id AS product_id,
        SUM(s.sales) AS total_sales,
        SUM(s.profit) AS total_profit,
        CASE 
            WHEN SUM(s.sales) = 0 THEN 0
            ELSE (SUM(s.profit) / SUM(s.sales)) * 100
        END AS profit_percentage
    FROM
        sales s
    WHERE  
        s.product_id = ANY(product_id_input)
    GROUP BY
        s.product_id;  -- for ensuring each product gets its own row
END;
$$ LANGUAGE plpgsql;


--Executing---
SELECT product_id, total_sales, total_profit, profit_percentage
FROM calculate_ANYproduct_profit (ARRAY['OFF-AR-10002833','FUR-CH-10002774']);
