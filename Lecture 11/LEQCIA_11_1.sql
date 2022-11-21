SELECT * FROM EMPLOYEES 


BEGIN
  INSERT_NEW_EMPLOYEE(P_EMPLOYEE_ID => 260,
                      P_FIRST_NAME => 'Tako',
                      P_LAST_NAME => 'Nozadze',
                      P_EMAIL => 'tnozadze@bog.ge',
                      P_PHONE_NUMBER => '213123',
                      P_HIRE_DATE => '31DEC2022',
                      P_JOB_ID => 'AD_VP',
                      P_SALARY => 1000,
                      P_COMMISSION_PCT => NULL,
                      P_MANAGER_ID => 100,
                      P_DEPARTMENT_ID => 90
                      );
END;



DECLARE 
  V_SOME_VAR_1 NUMBER := 10;
  V_SOME_VAR_2 NUMBER := 20;
  V_SOME_VAR_3 NUMBER;
  PI CONSTANT NUMBER := 3.14;

BEGIN 
  V_SOME_VAR_3 := V_SOME_VAR_1 + V_SOME_VAR_2;
  DBMS_OUTPUT.PUT_LINE('Value of variable_3 is '|| V_SOME_VAR_3);
END;


BEGIN 
  << OUTER_LOOP >>
  FOR i IN 1..10 LOOP
    << INNER_LOOP >>
    FOR j in 1..20 LOOP
        --SHEGVIDZLIA DIDI IF ERTI XAZIT CHAVANACVLOT
        --EXIT OUTER_LOOP WHEN I > 1;
        IF i > 1 THEN 
          EXIT;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Ricxvi 1: '|| i || ' Ricxvi 2:' || j);
    END LOOP INNER_LOOP;
  END LOOP OUTER_LOOP;
  DBMS_OUTPUT.PUT_LINE('Morcha loopi');
END;

BEGIN 
  << OUTER_LOOP >>
  FOR i IN 1..10 LOOP
    << INNER_LOOP >>
    FOR j in 1..20 LOOP
        --SHEGVIDZLIA DIDI IF ERTI XAZIT CHAVANACVLOT
        --EXIT OUTER_LOOP WHEN I > 1;
        IF j > 10 and j <= 12 THEN 
          CONTINUE;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Ricxvi 1: '|| i || ' Ricxvi 2:' || j);
    END LOOP INNER_LOOP;
  END LOOP OUTER_LOOP;
  DBMS_OUTPUT.PUT_LINE('Morcha loopi');
END;


--LOOPI CXRILZE
BEGIN 
  FOR I IN (
    SELECT EMPLOYEE_ID as emp_id, DEPARTMENT_ID FROM EMPLOYEES
    ) LOOP
  
DBMS_OUTPUT.PUT_LINE('tanamshromeli no: '|| i.emp_id || ' departmentis no: ' || i.department_id);
END LOOP;
END;

--go to
BEGIN 
  FOR I IN (
    SELECT EMPLOYEE_ID as emp_id, DEPARTMENT_ID FROM EMPLOYEES
    where employee_id = 101
    ) LOOP

<< SECTION_1 >>
IF I.EMP_ID > 100 THEN 
  GOTO SECTION_2;
END IF;

DELETE EMPLOYEES
WHERE EMPLOYEE_ID = I.EMP_ID;

<< SECTION_2 >>
UPDATE EMPLOYEES 
SET SALARY = SALARY * 1.1;
  
END LOOP;
END;



DECLARE 
  TYPE NAMESARRAY IS VARRAY(6) OF VARCHAR2(100);
  names NAMESARRAY;

BEGIN 
  names := namesarray('Tamuna','Giorgi', 'Nata', 'Ruso', 'Liza', 'Gigi');
  
  FOR I IN 1..names.count LOOP
    DBMS_OUTPUT.PUT_LINE('nomeri '|| i ||' saxeli '|| names(I));
  END LOOP;
end;


DECLARE 
  TYPE DATESARRAY IS VARRAY(12) OF DATE;
  dates DATESARRAY;

BEGIN 
  dates := DATESARRAY('31jan2022','28feb2022','31mar2022');
  
  FOR I IN 1..dates.count LOOP
    DBMS_OUTPUT.PUT_LINE('tarighi '|| dates(i));
  END LOOP;
  
  INSERT INTO RAGHACA_CXRILI
  SELECT * FROM EMPLOYEES 
  WHERE HIRE_DATE > dates(i);
end;




