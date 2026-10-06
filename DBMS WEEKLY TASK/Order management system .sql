SQL> CREATE TABLE Orders (
  2      Order_ID INT PRIMARY KEY,
  3      Customer_ID INT NOT NULL,
  4      Order_Date DATE NOT NULL,
  5      Total_Amount NUMBER(10,2) NOT NULL,
  6      FOREIGN KEY (Customer_ID)
  7          REFERENCES Customer(Customer_ID)
  8  );

Table created.

SQL> CREATE TABLE Order_Details (
  2      Order_Detail_ID INT PRIMARY KEY,
  3      Order_ID INT NOT NULL,
  4      Product_ID INT NOT NULL,
  5      Quantity INT NOT NULL,
  6      Unit_Price NUMBER(10,2) NOT NULL,
  7      Subtotal NUMBER(10,2) NOT NULL,
  8      FOREIGN KEY (Order_ID)
  9          REFERENCES Orders(Order_ID),
 10      FOREIGN KEY (Product_ID)
 11          REFERENCES Product(Product_ID)
 12  );

Table created.

SQL> INSERT INTO Orders
  2  (Order_ID, Customer_ID, Order_Date, Total_Amount)
  3  VALUES
  4  (501, 201, SYSDATE, 79999.00);

1 row created.

SQL>
SQL> INSERT INTO Orders
  2  (Order_ID, Customer_ID, Order_Date, Total_Amount)
  3  VALUES
  4  (502, 202, SYSDATE, 64999.00);

1 row created.

SQL>
SQL> INSERT INTO Orders
  2  (Order_ID, Customer_ID, Order_Date, Total_Amount)
  3  VALUES
  4  (503, 203, SYSDATE, 45999.00);

1 row created.

SQL> INSERT INTO Order_Details
  2  (Order_Detail_ID, Order_ID, Product_ID, Quantity, Unit_Price, Subtotal)
  3  VALUES
  4  (1001, 501, 101, 1, 79999.00, 79999.00);

1 row created.

SQL>
SQL> INSERT INTO Order_Details
  2  (Order_Detail_ID, Order_ID, Product_ID, Quantity, Unit_Price, Subtotal)
  3  VALUES
  4  (1002, 502, 102, 1, 64999.00, 64999.00);

1 row created.

SQL> SELECT *
  2  FROM Order_Details
  3  WHERE Order_Detail_ID = 1001;

ORDER_DETAIL_ID   ORDER_ID PRODUCT_ID   QUANTITY UNIT_PRICE   SUBTOTAL
--------------- ---------- ---------- ---------- ---------- ----------
           1001        501        101          1      79999      79999

SQL> INSERT INTO Order_Details
  2  (Order_Detail_ID, Order_ID, Product_ID, Quantity, Unit_Price, Subtotal)
  3  VALUES
  4  (1004, 501, 101, 1, 79999.00, 79999.00);

1 row created.

SQL> SELECT * FROM Order_Details;

ORDER_DETAIL_ID   ORDER_ID PRODUCT_ID   QUANTITY UNIT_PRICE   SUBTOTAL
--------------- ---------- ---------- ---------- ---------- ----------
           1001        501        101          1      79999      79999
           1002        502        102          1      64999      64999
           1004        501        101          1      79999      79999

SQL> UPDATE Orders
  2  SET Total_Amount = 84999.00
  3  WHERE Order_ID = 501;

1 row updated.

SQL> SELECT
  2      Order_ID,
  3      Customer_ID,
  4      Order_Date,
  5      Total_Amount
  6  FROM Orders
  7  WHERE Order_ID = 501;

  ORDER_ID CUSTOMER_ID ORDER_DAT TOTAL_AMOUNT
---------- ----------- --------- ------------
       501         201 06-OCT-26        84999

SQL> UPDATE Orders
  2  SET Order_Date = SYSDATE
  3  WHERE Order_ID = 502;

1 row updated.

SQL> UPDATE Order_Details
  2  SET Quantity = 2,
  3      Subtotal = 91998.00
  4  WHERE Order_Detail_ID = 1003;

0 rows updated.

SQL> SELECT
  2      C.Customer_ID,
  3      C.First_Name,
  4      C.Last_Name,
  5      O.Order_ID,
  6      O.Order_Date,
  7      P.Product_Name,
  8      OD.Quantity,
  9      OD.Unit_Price,
 10      OD.Subtotal,
 11      O.Total_Amount
 12  FROM Customer C
 13  JOIN Orders O
 14      ON C.Customer_ID = O.Customer_ID
 15  JOIN Order_Details OD
 16      ON O.Order_ID = OD.Order_ID
 17  JOIN Product P
 18      ON OD.Product_ID = P.Product_ID
 19  ORDER BY
 20      C.Customer_ID,
 21      O.Order_Date;

CUSTOMER_ID FIRST_NAME
----------- --------------------------------------------------
LAST_NAME                                            ORDER_ID ORDER_DAT
-------------------------------------------------- ---------- ---------
PRODUCT_NAME
--------------------------------------------------------------------------------
  QUANTITY UNIT_PRICE   SUBTOTAL TOTAL_AMOUNT
---------- ---------- ---------- ------------
        201 Arun
Kumar                                                     501 06-OCT-26
iPhone 15
         1      79999      79999        84999


CUSTOMER_ID FIRST_NAME
----------- --------------------------------------------------
LAST_NAME                                            ORDER_ID ORDER_DAT
-------------------------------------------------- ---------- ---------
PRODUCT_NAME
--------------------------------------------------------------------------------
  QUANTITY UNIT_PRICE   SUBTOTAL TOTAL_AMOUNT
---------- ---------- ---------- ------------
        201 Arun
Kumar                                                     501 06-OCT-26
iPhone 15
         1      79999      79999        84999


CUSTOMER_ID FIRST_NAME
----------- --------------------------------------------------
LAST_NAME                                            ORDER_ID ORDER_DAT
-------------------------------------------------- ---------- ---------
PRODUCT_NAME
--------------------------------------------------------------------------------
  QUANTITY UNIT_PRICE   SUBTOTAL TOTAL_AMOUNT
---------- ---------- ---------- ------------
        202 Priya
Sharma                                                    502 06-OCT-26
Samsung Galaxy S24
         1      64999      64999        64999


SQL> SELECT
  2      C.Customer_ID,
  3      C.First_Name,
  4      C.Last_Name,
  5      COUNT(O.Order_ID) AS Total_Orders,
  6      SUM(O.Total_Amount) AS Total_Amount
  7  FROM Customer C
  8  LEFT JOIN Orders O
  9      ON C.Customer_ID = O.Customer_ID
 10  GROUP BY
 11      C.Customer_ID,
 12      C.First_Name,
 13      C.Last_Name
 14  ORDER BY C.Customer_ID;

CUSTOMER_ID FIRST_NAME
----------- --------------------------------------------------
LAST_NAME                                          TOTAL_ORDERS TOTAL_AMOUNT
-------------------------------------------------- ------------ ------------
        201 Arun
Kumar                                                         1        84999

        202 Priya
Sharma                                                        1        64999

        203 Rahul
Raj                                                           1        45999

