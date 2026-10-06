SQL> CREATE TABLE Payment (
  2      Payment_ID INT PRIMARY KEY,
  3      Order_ID INT,
  4      Payment_Method VARCHAR2(30),
  5      Payment_Date DATE NOT NULL,
  6      Payment_Status VARCHAR2(20),
  7      Amount NUMBER(10,2) NOT NULL,
  8      FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
  9  );
CREATE TABLE Payment (
             *
ERROR at line 1:
ORA-00955: name is already used by an existing object


SQL> DROP TABLE Payment;

Table dropped.

SQL> CREATE TABLE Payment (
  2      Payment_ID INT PRIMARY KEY,
  3      Order_ID INT,
  4      Payment_Method VARCHAR2(30),
  5      Payment_Date DATE NOT NULL,
  6      Payment_Status VARCHAR2(20),
  7      Amount NUMBER(10,2) NOT NULL,
  8      FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
  9  );

Table created.

SQL> INSERT INTO Payment
  2  VALUES (701, 501, 'UPI', SYSDATE, 'Successful', 84999.00);

1 row created.

SQL>
SQL> INSERT INTO Payment
  2  VALUES (702, 502, 'Credit Card', SYSDATE, 'Successful', 799.00);

1 row created.

SQL>
SQL> INSERT INTO Payment
  2  VALUES (703, 503, 'Debit Card', SYSDATE, 'Failed', 45999.00);

1 row created.

SQL> SELECT * FROM Payment;

PAYMENT_ID   ORDER_ID PAYMENT_METHOD                 PAYMENT_D
---------- ---------- ------------------------------ ---------
PAYMENT_STATUS           AMOUNT
-------------------- ----------
       701        501 UPI                            06-OCT-26
Successful                84999

       702        502 Credit Card                    06-OCT-26
Successful                  799

       703        503 Debit Card                     06-OCT-26
Failed                    45999


SQL> SELECT *
  2  FROM Payment
  3  WHERE Payment_Status = 'Successful';

PAYMENT_ID   ORDER_ID PAYMENT_METHOD                 PAYMENT_D
---------- ---------- ------------------------------ ---------
PAYMENT_STATUS           AMOUNT
-------------------- ----------
       701        501 UPI                            06-OCT-26
Successful                84999

       702        502 Credit Card                    06-OCT-26
Successful                  799


SQL> SELECT *
  2  FROM Payment
  3  WHERE Payment_Status = 'Failed';

PAYMENT_ID   ORDER_ID PAYMENT_METHOD                 PAYMENT_D
---------- ---------- ------------------------------ ---------
PAYMENT_STATUS           AMOUNT
-------------------- ----------
       703        503 Debit Card                     06-OCT-26
Failed                    45999


SQL> UPDATE Payment
  2  SET Payment_Status = 'Successful'
  3  WHERE Payment_ID = 703;

1 row updated.

SQL> SELECT
  2      Payment_Method,
  3      COUNT(*) AS Total_Transactions,
  4      SUM(Amount) AS Total_Amount
  5  FROM Payment
  6  GROUP BY Payment_Method;

PAYMENT_METHOD                 TOTAL_TRANSACTIONS TOTAL_AMOUNT
------------------------------ ------------------ ------------
UPI                                             1        84999
Credit Card                                     1          799
Debit Card                                      1        45999

SQL> SELECT
  2      Payment_Method,
  3      SUM(Amount) AS Amount_Collected
  4  FROM Payment
  5  GROUP BY Payment_Method;

PAYMENT_METHOD                 AMOUNT_COLLECTED
------------------------------ ----------------
UPI                                       84999
Credit Card                                 799
Debit Card                                45999

SQL> SELECT
  2      Payment_ID,
  3      Order_ID,
  4      Payment_Method,
  5      Payment_Date,
  6      Payment_Status,
  7      Amount
  8  FROM Payment
  9  ORDER BY Payment_ID;

PAYMENT_ID   ORDER_ID PAYMENT_METHOD                 PAYMENT_D
---------- ---------- ------------------------------ ---------
PAYMENT_STATUS           AMOUNT
-------------------- ----------
       701        501 UPI                            06-OCT-26
Successful                84999

       702        502 Credit Card                    06-OCT-26
Successful                  799

       703        503 Debit Card                     06-OCT-26
Successful                45999

