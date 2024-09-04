-- Monthly_sales CTE 
WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', st.purchase_date) AS month,
        SUM(st.quantity_purchased * p.price) AS total_sales_amount,
        COUNT(DISTINCT st.transaction_id) AS total_transactions
    FROM 
        sales_transactions st
    JOIN 
        products p ON st.product_id = p.product_id
    GROUP BY 
        DATE_TRUNC('month', st.purchase_date)
),

-- This CTE calculates the total sales amount and number of transactions for each month
-- It uses the DATE_TRUNC function to extract the month from paurchase_date column
-- Also, it calculates the total amount of sales and distinct number of transactions

-- Moving_average CTE 
moving_average AS (
    SELECT 
        month,
        total_sales_amount,
        total_transactions,
        AVG(total_sales_amount) OVER (
            ORDER BY month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS three_month_moving_avg
    FROM 
        monthly_sales
)

-- This CTE build upon the monthly_sales CTE to calculate the 3 month average
-- It uses a window function to calculate the moving average.
-- The window is defined as ROWS BETWEEN 2 PRECEDING AND CURRENT ROW, which includes the current month and the two preceding months.
SELECT 
    month,
    total_sales_amount,
    total_transactions,
    ROUND(three_month_moving_avg, 2) AS three_month_moving_avg
FROM 
    moving_average
ORDER BY 
    month;