SET SERVEROUTPUT ON SIZE UNLIMITED
SET VERIFY OFF

DECLARE
    TYPE list IS TABLE OF INTEGER;
    lv_int_list LIST;
    lv_int_item INTEGER;
    
BEGIN
    lv_int_list := list(1, 2, 3, 4);
    
    FOR i IN 1..lv_int_list.COUNT LOOP
        
        lv_int_item := lv_int_list(i);
    
        CASE lv_int_item
            WHEN 1 THEN
                dbms_output.put_line('"'||lv_int_item||'" is "1"');
            WHEN 2 THEN
                dbms_output.put_line('"'||lv_int_item||'" is "2"');
            WHEN 3 THEN
                dbms_output.put_line('"'||lv_int_item||'" is "3"');
            ELSE
                dbms_output.put_line('"'||lv_int_item||'" is not found!');
        END CASE;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
END;
/