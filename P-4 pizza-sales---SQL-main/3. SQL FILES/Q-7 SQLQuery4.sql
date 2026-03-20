--Determine the distribution of orders by hour of the day.

SELECT DATEPART(HOUR, order_time) AS order_hour, COUNT(order_id) AS order_count
FROM orders
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time);
