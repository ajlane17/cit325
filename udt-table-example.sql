SET SERVEROUTPUT ON SIZE UNLIMITED
SET VERIFY OFF

-- Remove the types if they exist
DECLARE
    lv_exists number;
BEGIN
    SELECT COUNT(*) INTO lv_exists FROM user_types WHERE type_name = 'TEMP_EMPLOYEE_TABLE';
    IF lv_exists = 1 THEN
        execute immediate 'DROP TYPE TEMP_EMPLOYEE_TABLE';
    END IF;
    
    lv_exists := 0;
    
    SELECT COUNT(*) INTO lv_exists FROM user_types WHERE type_name = 'TEMP_EMPLOYEE';
    IF lv_exists = 1 THEN
        EXECUTE IMMEDIATE 'DROP TYPE TEMP_EMPLOYEE';
    END IF;
END;
/
-- Create temp_employee UDT
CREATE OR REPLACE TYPE temp_employee IS OBJECT (
    first_name VARCHAR2(20),
    last_name VARCHAR2(20),
    salary INTEGER);
/

-- Create table of temp_employee UDT
CREATE OR REPLACE TYPE temp_employee_table IS TABLE OF TEMP_EMPLOYEE;
/

-- Populate the table and loop through it to display data
DECLARE
    lv_temp_employee_table TEMP_EMPLOYEE_TABLE := TEMP_EMPLOYEE_TABLE(
                                                      temp_employee('Bob','Ross',40000),
                                                      temp_employee('Bill','Murray',35000),
                                                      temp_employee('Susan','Lang',24000));

BEGIN
    for i in 1..lv_temp_employee_table.count LOOP
        dbms_output.put_line(lv_temp_employee_table(i).first_name||', '||lv_temp_employee_table(i).last_name||', '||lv_temp_employee_table(i).salary);
    END LOOP;
END;
/