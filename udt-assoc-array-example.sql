SET SERVEROUTPUT ON SIZE UNLIMITED
SET VERIFY OFF

DECLARE
    TYPE temp_department IS RECORD (
        department_employee_count PLS_INTEGER,
        department_location VARCHAR(20),
        department_code PLS_INTEGER);
        
    TYPE temp_department_table IS TABLE OF temp_department
        INDEX BY VARCHAR(20);
        
    temp_departments TEMP_DEPARTMENT_TABLE;
    i VARCHAR(20);
    
BEGIN
    temp_departments('accounting').department_employee_count := 5;
    temp_departments('accounting').department_location := 'first floor';
    temp_departments('accounting').department_code := 103;
    temp_departments('hr').department_employee_count := 3;
    temp_departments('hr').department_location := 'second floor';
    temp_departments('hr').department_code := 104;
    temp_departments('it').department_employee_count := 7;
    temp_departments('it').department_location := 'basement';
    temp_departments('it').department_code := 202;
    
    i := temp_departments.FIRST;
    
    WHILE i IS NOT NULL LOOP
        dbms_output.put_line('Department info for ' || i || ': employees - ' || temp_departments(i).department_employee_count || ', location - ' || temp_departments(i).department_location);
        i := temp_departments.NEXT(i);
    END LOOP;
END;
/