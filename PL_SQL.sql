--PL SQL CODE
SET SERVEROUTPUT ON
DECLARE
  L_NAME VARCHAR2;     
BEGIN
  L_NAME := 'Humna Humna';
END;

--declaration section: declaring variable
DECLARE 
  L_MESSAGE VARCHAR2(20); 
--executable section
BEGIN
  L_MESSAGE := 'hELLO wALLY wORLD!';
  DBMS_OUTPUT.PUT_LINE(L_MESSAGE);
END;


DECLARE
  L_NAME VARCHAR(20) DEFAULT 'Ilsa';
  L_STATUS BOOLEAN := TRUE;
BEGIN
  L_NAME := 'Humna Humna';
  
  IF L_STATUS THEN --IF condition THEN
    DBMS_OUTPUT.PUT_LINE ('IT IS TRUE THAT ' || L_NAME || 'IS SILLY');  --executable statements
  ELSE --ELSIF
    DBMS_OUTPUT.PUT_LINE ('IT IS FALSE THAT ' || L_NAME || 'IS SILLY');
  END IF;
  
  DBMS_OUTPUT.PUT_LINE(L_NAME);
END;

--THE PL/SQL CONDITIONAL & BOOLEAN VARIABLE USE

--declaration section
DECLARE 
  L_FAVORITE_FOOD VARCHAR2(20) DEFAULT 'BULGOGI';
  L_STATUS BOOLEAN := TRUE;
--executable section
BEGIN
  L_FAVORITE_FOOD := 'BIBIMBOB';

  IF L_STATUS THEN --IF condition THEN
    DBMS_OUTPUT.PUT_LINE ('IT IS TRUE THAT ' || L_FAVORITE_FOOD || ' IS MY FAVORITE FOOD! ');  --executable statements
  ELSE --ELSIF
    DBMS_OUTPUT.PUT_LINE ('IT IS FALSE THAT ' || L_FAVORITE_FOOD|| ' IS NOT MY FAVORITE FOOD. ');
  END IF;
 
  DBMS_OUTPUT.PUT_LINE(L_FAVORITE_FOOD);
END;

--LOOP 1
--Different approach
SET SERVEROUP ON
DECLARE
  L_FNAME CUSTOMER.C_FIRST%TYPE;
  L_MI CUSTOMER.C_MI%TYPE;
  L_LNAME CUSTOMER.C_LAST%TYPE;
  L_COUNTER NUMBER := 0;

BEGIN
  LOOP 
      --L_COUNTER := C_ID;
      L_COUNTER := L_COUNTER +1;
      EXIT WHEN L_COUNTER  > 6;
      
      SELECT C_FIRST, C_MI, C_LAST
      INTO L_FNAME, L_MI, L_LNAME
      FROM CUSTOMER
      WHERE C_ID = L_COUNTER;
      
      DBMS_OUTPUT.PUT_LINE('CUSTOMER NAME: '|| L_COUNTER || ' ' || L_FNAME || ' ' || L_MI || ' ' || L_LNAME|| L_MI );
  END LOOP;
--control resumes here after EXIT
--DBMS_OUTPUT.PUT_LINE( 'WE HAVE: ' || l_counter || ' CUSTOMERS' );

END;


--LOOP2
DECLARE
  L_FNAME VARCHAR(30);
  L_MI CHAR(1);
  L_LNAME VARCHAR(30);
  L_COUNTER NUMBER := 0;

BEGIN

  FOR C IN (SELECT C_FIRST, C_MI, C_LAST
            FROM CUSTOMER
            )

LOOP

    L_COUNTER := L_COUNTER + 1;

    --EXIT WHEN L_COUNTER > 7;
    
    DBMS_OUTPUT.PUT_LINE('CUSTOMER NAME: '|| L_COUNTER || ' ' || C.C_FIRST || ' ' || C.C_MI || ' ' || C.C_LAST|| C.C_MI );
   
END LOOP;

--control resumes here after EXIT
DBMS_OUTPUT.PUT_LINE( 'WE HAVE: ' || l_counter || ' CUSTOMERS' );

END;


--EXPLICIT CURSOR
SET SERVEROUTPUT ON

DECLARE
  L_COUNT NUMBER(5);

  CURSOR JEONG_CURSOR IS
    SELECT C_LAST, C_MI, C_FIRST
    FROM CUSTOMER;
  JEONG_CURSOR_ROW JEONG_CURSOR%ROWTYPE;

BEGIN
  OPEN JEONG_CURSOR;
  LOOP 
    FETCH JEONG_CURSOR INTO JEONG_CURSOR_ROW;
    IF JEONG_CURSOR%FOUND THEN
      L_COUNT := JEONG_CURSOR%ROWCOUNT; 
      DBMS_OUTPUT.PUT_LINE (L_COUNT|| ': '|| JEONG_CURSOR_ROW.C_LAST || ' ' || JEONG_CURSOR_ROW.C_MI || ' ' || JEONG_CURSOR_ROW.C_LAST );
    ELSE
      DBMS_OUTPUT.PUT_LINE ('ALL DONE');
      CLOSE JEONG_CURSOR;
      EXIT;
    END IF;
  END LOOP;
  IF JEONG_CURSOR%ISOPEN THEN 
      DBMS_OUTPUT.PUT_LINE ('A CURSOR IS OPEN');
    ELSE
      DBMS_OUTPUT.PUT_LINE ('A CURSOR IS CLOSED');
    END IF;  
END;


--CURSOR FOR LOOP VERSION

BEGIN
  FOR BOB IN (SELECT C_FIRST, C_MI, C_LAST FROM CUSTOMER) LOOP
    DBMS_OUTPUT.PUT_LINE (BOB.C_FIRST || ' ' || BOB.C_MI || ' ' || BOB.C_LAST );
  END LOOP;
  DBMS_OUTPUT.PUT_LINE ('ALL DONE');
END;


--CREATE A STAGING AREA  IN CLEARWATER SALES DEPT WANTS TO BE ABLE TO
--MEASURE REVENUE BY INFLUENCING FACTORS INCLUDING ITEM NAME AND SALE MONTH

SELECT (OL.OL_QUANTITY * I.INV_PRICE) REVENUE
       , ITEM_DESC AS PRODUCT
       , TO_CHAR(O.O_DATE, 'MONTH') AS MONTH
FROM CLEARWATER.ORDER_LINE OL JOIN CLEARWATER.INVENTORY I ON (OL.INV_ID = I.INV_ID)
                              JOIN CLEARWATER.ORDERS O ON (O.O_ID = OL.O_ID)
                              JOIN CLEARWATER.ITEM IT ON (I.ITEM_ID = IT.ITEM_ID)
ORDER BY MONTH
