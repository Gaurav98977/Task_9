-------------------------------TASK-9--------------------------------------

--- Calculating the total sales , total profit and profit percentage
--- by giving the product_id 

select*from sales
-- Columns we need 'Product-ID','Sales','Profit';

	
CREATE OR REPLACE FUNCTION calculate_product_profit(product_id_input VARCHAR)

--- We make this query just because we want to return a table 
--- It specifies the data type in which our output has been showed
--- such as Product - ID , Total sales , Total profit , Profit_percentage
	
	 
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
    
	
	
	-- We use 'FROM' to specify which table has this overall data
	FROM
        sales s
   
	--- We are going to use the 'WHERE' function just because
	--- The sales table has many columns just to specify
	--- Which columns we need to use
	WHERE  
		s.product_id = product_id_input;
END;
$$ LANGUAGE plpgsql;

--- Executing the function

SELECT product_id, total_sales, total_profit, profit_percentage
FROM calculate_product_profit('FUR-TA-10000577');

