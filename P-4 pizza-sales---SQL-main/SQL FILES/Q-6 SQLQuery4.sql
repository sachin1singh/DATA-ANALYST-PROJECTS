--Join the necessary tables to find the total quantity of each pizza category ordered.

select pizza_types.category,sum(order_details.quantity) as quantity
from pizza_types
                      join
                      pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
					  JOIN
                         order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC