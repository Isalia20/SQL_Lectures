/* 1. დაწერეთ პროცედურა, რომელიც მის მომხმარებლებს დაეხმარება შემდეგში:

მომხმარებელს უნდა ჰქონდეს ახალი თანამშრომლის რეგისტრაციის საშუალება, მას უნდა შეეძლოს ყველა ველის მითითება, რაც employees ცხრილში არსებობს.
ასევე სანამ ახალი თანამშრომლის რეგისტრაციას გააკეთებთ მანამდე უნდა შემოწმდეს 3 რამ:
1) ხომ არ არის ამ უნიკალური ID-ით თანამშრომელი უკვე რეგისტრირებული ცხრილში
2) ხელფასი, ხომ არ აღემატება კომპანიაში ჯამური ხელფასის 15%-ს.
3) დასაქმების დაწყების თარიღი(hire_date) არ უნდა იყოს მეტი დღევანდელ თარიღზე

თუ მოხდება 1-ლი შემთხვევა ზემოთ ჩამოთვლილთაგან, მაშინ ერორზე არ გაიყვანოთ პროცედურა, უბრალოდ კომენტარად დაუწერეთ:
"Employee ID already exists"

თუ მოხდება მე-2 შემთხვევა მაშინ დაწერეთ "salary too high"

თუ მოხდება მე-3 შემთხვევა მაშინ დაწერეთ "invalid hire date".
*/ 
CREATE OR REPLACE PROCEDURE MY_FIRST_PROCEDURE (
P_EMPLOYEE_ID NUMBER,
P_FIRST_NAME VARCHAR2,
P_LAST_NAME VARCHAR2,
P_EMAIL VARCHAR2,
P_PHONE_NUMBER VARCHAR2,
P_HIRE_DATE DATE,
P_JOB_ID VARCHAR2,
P_SALARY NUMBER,
P_COMMISSION_PCT NUMBER,
P_MANAGER_ID NUMBER,
P_DEPARTMENT_ID NUMBER
) IS 

EXIT_EXISTS_CONDITION EXCEPTION;
EXIT_HIGH_SALARY_CONDITION EXCEPTION;
EXIT_LATE_START_DATE EXCEPTION;
V_EMP_COUNT NUMBER;
V_TOTAL_SALARY NUMBER;


BEGIN 
  
  SELECT COUNT(1) 
  INTO V_EMP_COUNT
  FROM EMPLOYEES 
  WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;
  
  IF V_EMP_COUNT > 0 THEN 
    RAISE EXIT_EXISTS_CONDITION;
  END IF;
  
  SELECT SUM(SALARY) 
  INTO V_TOTAL_SALARY
  FROM EMPLOYEES;
  
  IF V_TOTAL_SALARY * 0.15 < P_SALARY THEN 
    RAISE EXIT_HIGH_SALARY_CONDITION;
  END IF;
  
  IF P_HIRE_DATE > SYSDATE THEN
    RAISE EXIT_LATE_START_DATE;
  END IF;
  

  INSERT INTO EMPLOYEES 
  VALUES (P_EMPLOYEE_ID, P_FIRST_NAME, P_LAST_NAME, P_EMAIL,
          P_PHONE_NUMBER, P_HIRE_DATE, P_JOB_ID, P_SALARY,
          P_COMMISSION_PCT, P_MANAGER_ID, P_DEPARTMENT_ID);
  COMMIT;
  
  EXCEPTION 
    WHEN EXIT_EXISTS_CONDITION THEN 
      DBMS_OUTPUT.PUT_LINE('Aseti Tanamshromeli ukve arsebobs');
    WHEN EXIT_HIGH_SALARY_CONDITION THEN 
      DBMS_OUTPUT.PUT_LINE('Too high salary');
    WHEN EXIT_LATE_START_DATE THEN 
      DBMS_OUTPUT.PUT_LINE('Invalid start date');
  
END;
/
