SELECT EXTRACT (DAY FROM SYSDATE) FROM DUAL;
--5. დაასელექთეთ ისეთი დასაქმებულები რომლებიც ისეთ დეპარტამენტში მუშაობენ, რომელთა ID მთავრდება 0-ით 

select * from employees 
where mod(department_id,10) = 0;

--department_id like '%0';

--7. დაასელექთეთ ისეთი თანამშრომლები რომელთა სახელიც იწყება S-ით ან A-ით ან B-ით და ეს 
--თანამშრომლები არიან დასაქმებულები 15 ივლისი 2003-ის შემდეგ. 
--ასევე გამოიტანეთ თანამშრომლები რომელთა გვარის მე-4 ასო არის ან j ან g. 
SELECT * FROM EMPLOYEES 
WHERE ((FIRST_NAME LIKE 'S%' OR FIRST_NAME LIKE 'A%' OR FIRST_NAME 'B%') AND 
        HIRE_DATE >= '15JUL2003') 
        OR 
        (SUBSTR(LAST_NAME, 4, 1) = 'j' or SUBSTR(LAST_NAME, 4, 1) = 'g')
        
        
8. დაასელექთეთ თანამშრომლის სახელი, გვარი, job_id და გამოიტანეთ ახალი სვეტი შემდეგი ლოგიკით:
თუ ტელეფონის ნომერი არის 12 ნიშანზე მეტი დაწერეთ Wrong Number სხვა შემთხვევაში დაწერეთ Correct Number.

ამის შემდეგ გამოიტანეთ ისევ ახალი სვეტი. თუ თქვენს წინა ახალ შექმნილ სვეტში წერია Correct Number მაშინ 
გამოიტანეთ თანამშრომლის manager_id-ის ნაშთი 14-ზე, თუ წერია Wrong Number არაფერი არ გამოიტანოთ.

select first_name, last_name, job_id,
       case when 
       case when length(phone_number) > 12 then 'Wrong Number' 
       ELSE 'Correct Number'
       end = 'Correct Number' then mod(manager_id, 14) 
       else --shegvidzlia else ar gvqondes, mainc nulls daabrunebs
       null
       end
       from employees;
       


14. გვაქვს შემდეგი pattern-ი მოცემული:
"სიტყვა სიტყვაsql"
მაგ:
"meagterf sdvtrsqlefgtfsql"
ამ წინადადებიდან ამოიღეთ sql-მდე არსებული სიტყვა. ზედა შემთხვევაში ეს იქნება:
"sdvtrefgtf"
გაითვალისწინეთ, რომ საბოლოო სიტყვაში შეიძლება ფიგურირებდეს sql!!!


select 
substr(
substr('meagterf sdvtrsqlefgtfsql', 1, length('meagterf sdvtrsqlefgtfsql') -3),
instr(substr('meagterf sdvtrsqlefgtfsql', 1, length('meagterf sdvtrsqlefgtfsql') -3 ),' ') + 1)
from dual;



17. ვინ არის ის თანამშრომელი რომლის გვარის პირველი ასო იწყება T-ზე? გამოიტანეთ ეს თანამშრომელი. 
დავალაგოთ იმეილის სიგრძის მიხედვით კლებადობით. ანუ რაც უფრო დიდი მეილი აქვს ის ადამიანები პირველად გამოვაჩინოთ, 
ხოლო ყველაზე პატარები ქვემოთ, 
შემდეგ კი დავალაგოთ თანამშრომლის სახელის მე-6 ასოთი, 
ასეთის არ არსებობის შემთხვევაში დავალაგოთ სახელის 1-ლი ასოთი.

select * from employees 
WHERE LAST_NAME LIKE 'T%'
ORDER BY LENGTH(EMAIL) DESC,
         CASE WHEN LENGTH(FIRST_NAME) >= 6 THEN SUBSTR(FIRST_NAME, 6, 1)
         ELSE SUBSTR(FIRST_NAME, 1, 1)
         END


-------------------------------------------------------------------------------------------------------------------
SELECT * FROM EMPLOYEES 
WHERE COMMISSION_PCT IS NULL;

SELECT * FROM EMPLOYEES 
WHERE COMMISSION_PCT IS NOT NULL;

SELECT NVL(COMMISSION_PCT, 0.4) FROM EMPLOYEES;
--ZUSTAD IGIVE IQNEBODA
SELECT CASE WHEN COMMISSION_PCT IS NULL THEN 0.4 ELSE COMMISSION_PCT END FROM EMPLOYEES;

--BETWEEN
SELECT * FROM EMPLOYEES 
WHERE SALARY >= 5000 AND SALARY <= 10000;

SELECT * FROM EMPLOYEES
WHERE SALARY BETWEEN 6000 AND 10000;

-----------------------------------------------------------------------------------
--DATE FUNCTIONS 
--DATE, TIMESTAMP
SELECT SYSDATE FROM DUAL;
SELECT CURRENT_TIMESTAMP FROM DUAL;

--ROMEL TIMEZONESHI ARIS CHVENI BAZA
SELECT DBTIMEZONE FROM DUAL;

--DGHIS AMOGHEBA
SELECT EXTRACT(DAY FROM SYSDATE) FROM DUAL;
-- TVIS
SELECT EXTRACT (MONTH FROM SYSDATE) FROM DUAL;
-- WLIS
SELECT EXTRACT (YEAR FROM SYSDATE) FROM DUAL;
-- SAATI 24 SAATIAN FORMATSHI
SELECT TO_CHAR(SYSDATE, 'HH24') FROM DUAL;  -- TO_CHARACTER
-- WUTEBI
SELECT TO_CHAR(SYSDATE, 'MI') FROM DUAL;
-- WAMEBI 
SELECT TO_CHAR(SYSDATE, 'SS') FROM DUAL;

--DATEIS FUNQCIEBI 
--LAST DAY
SELECT LAST_DAY(HIRE_DATE) FROM EMPLOYEES;
--MONTHS BETWEEN
SELECT MONTHS_BETWEEN(SYSDATE + 80, SYSDATE)  FROM DUAL;
--DAYS BETWEEN
SELECT (SYSDATE + 1) - SYSDATE FROM DUAL;
--NEXT_DAY 
SELECT NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 'FRI') FROM DUAL;
--TO_DATE, STRINGIDAN GADAHYAVS TARIGHSHI
SELECT TO_DATE('25-06-2001', 'DD-MM-YYYY') FROM EMPLOYEES;
SELECT TO_DATE('25/06/2001', 'DD/MM/YYYY') FROM EMPLOYEES;
--TO_CHAR DATEBZE
SELECT TO_CHAR(SYSDATE,'DD-MON-YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY/MM') FROM DUAL;
--TRUNC 
SELECT TRUNC(15.64) FROM DUAL;
SELECT TRUNC(SYSDATE), SYSDATE FROM DUAL;
-----------------
SELECT HIRE_DATE FROM EMPLOYEES 
WHERE HIRE_DATE > '15JUN2022';

SELECT HIRE_DATE FROM EMPLOYEES 
WHERE HIRE_DATE >= '16JUN2022';

--16 IVNISIS CHANAWEREBI AR WAMOVA
SELECT HIRE_DATE FROM EMPLOYEES 
WHERE HIRE_DATE <= '16JUN2022';


----------------------------------------------------------------------------------
--SUBQUERY
-- ORDER BY COLUMNIS RIGITOBIT
SELECT employee_id, salary FROM EMPLOYEES 
WHERE FIRST_NAME = 'Steven'
ORDER BY 2;

--------------------------------
SELECT employee_id, salary FROM EMPLOYEES 
WHERE FIRST_NAME = 'Steven'
ORDER BY 2;

-- WAMOVIGHOT ISETI TANAMSHROMLEBI ROMLEBIC MUSHAOBEN ISET DEPARTAMENTSHI ROMELTAC
-- MANAGERI AR HYAVT(MANAGER_ID IS NULL DEPARTAMENTS CXRILSHI)
SELECT * FROM DEPARTMENTS
WHERE LOCATION_ID = 1700;

SELECT * FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE LOCATION_ID = 1700);

--ESETI SUBQUERY AR DAVWEROT
SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 100);
--ROCA SHEGVEDZLO DAGVEWERA
SELECT * FROM EMPLOYEES 
WHERE EMPLOYEE_ID = 100;



SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM JOB_HISTORY)
AND DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS 
                      WHERE DEPARTMENT_NAME LIKE 'A%'
                      AND LOCATION_ID IN (
                      SELECT LOCATION_ID FROM LOCATIONS 
                      WHERE STREET_ADDRESS LIKE '%cho%'
                      )
                      );
--GVAINTERESEBS ISETI TANAMSHROMLEBI ROMLEBIC MUSHAOBEN BRAZIL-SHI
SELECT * FROM EMPLOYEES 
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS
                        WHERE LOCATION_ID IN (
                        SELECT LOCATION_ID FROM LOCATIONS 
                        WHERE COUNTRY_ID IN (
                        SELECT COUNTRY_ID FROM COUNTRIES 
                        WHERE COUNTRY_NAME = 'United States of America' )));

--RAMDENI DGHE ARIS DARCHENILI SHABATAMDE?
--GAMOITANET TANAMSHROMLEBI ROMLEBIC DASAQMEBULEBI ARIAN NAKIAN WELIWADSHI
--VIN ARIS IS TANAMSHROMELI ROMELIC MUSHAOBS me-4 regionshi?


select to_date('31dec2020','DDMONYYYY') - TO_DATE('31DEC2019','DDMONYYYY') from dual


select * from employees
where 
extract (day from add_months(to_date('01feb' || extract (year from hire_date)), 1) - 1) = 29



select * from regions
