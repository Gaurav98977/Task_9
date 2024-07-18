select*from sales

--- Calculating the total sales , total profit and profit percentage
--- by giving the product_id 
	
CREATE OR REPLACE FUNCTION calculate_product_profit(product_id_input VARCHAR)
RETURNS TABLE (
    product_id VARCHAR,
    total_sales DOUBLE PRECISION,
    total_profit DOUBLE PRECISION,
    profit_percentage DOUBLE PRECISION
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        product_id_input AS product_id,
        SUM(s.sales) AS total_sales,--- calculating the total sales
        SUM(s.profit) AS total_profit, -- calculating the total profit
        CASE 
            WHEN SUM(s.sales) = 0 THEN 0
            ELSE (SUM(s.profit) / SUM(s.sales)) * 100 --calculating the profit percentage
        END AS profit_percentage
    FROM
        sales s
    WHERE
        s.product_id = product_id_input;
END;
$$ LANGUAGE plpgsql;

--- Executing the function

SELECT product_id, total_sales, total_profit, profit_percentage
FROM calculate_product_profit('FUR-BO-10001798');

