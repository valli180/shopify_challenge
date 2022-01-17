/* Solution to SQL challenge */

/* Query for the first problem. Selects distinct orderID from Orders 
and joined with Shippers table to filter records of Shipper with ShipperID = 1*/

-- How many orders were shipped by Speedy Express in total?

SELECT count(DISTINCT O.OrderID)
FROM Orders AS O
JOIN Shippers AS S
ON O.ShipperID =S.ShipperID
WHERE S.ShipperID = 1;

--SOLUTION: 54

-- What is the last name of the employee with the most orders?
/* Query uses the concept of subquery to extract the EmployeeID with maximum
orders from the Orders table. This is used to obtain the LastName from the
Employees table. Subqueries are usually slow and instead a CTE or Windows Functions can 
also be used to obtain the same as in solution 2  */

--Solution 1

SELECT LastName 
FROM Employees
WHERE EmployeeID = (
    SELECT EmployeeID
    FROM Orders
    GROUP BY EmployeeID
    ORDER BY Count(OrderID) DESC
    LIMIT 1);

--Solution 2

SELECT LastName






--SOLUTION: Peacock

-- What product was ordered the most by customers in Germany?
/* Used the concept of CTEs to create a temp table with all the required joins 
made to extract columns of interest and then obtain the ProductName from the 
temp table created */

WITH temp AS(
SELECT Od.ProductID, Od.Quantity, Od.OrderID, O.OrderID, O.CustomerID, C.CustomerID, C.Country
FROM OrderDetails AS Od
JOIN Orders AS O
ON Od.OrderID = O.OrderID
JOIN Customers AS C
ON C.CustomerID = O.CustomerID)

SELECT ProductName
FROM (
    SELECT t.ProductID, sum(t.Quantity) AS Total_Quantity, t.Country, p.ProductName
    FROM temp AS t
    JOIN Products AS p
    ON t.ProductID = p.ProductID
    GROUP BY t.Country, t.ProductID
    HAVING t.Country = "Germany" ) 
ORDER BY Total_Quantity DESC
LIMIT 1

--SOLUTION: Boston Crab Meat
