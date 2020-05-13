SET SERVEROUTPUT ON SIZE UNLIMITED
SET VERIFY OFF

DECLARE
    TYPE list IS TABLE OF CHAR;
    lv_char_list LIST;
    lv_char1_other CHAR := '&';
    lv_char2_other CHAR := '4';
    
    PROCEDURE char_type
      ( pv_char1_in IN CHAR,
        pv_char2_in IN CHAR DEFAULT NULL) IS
      BEGIN 
        CASE
            WHEN pv_char2_in IS NOT NULL  THEN
                dbms_output.put_line('"'||pv_char2_in||'" Was included as an optional parameter!');
            WHEN pv_char1_in BETWEEN 'a' AND 'z' THEN
                dbms_output.put_line('"'||pv_char1_in||'" is a lower-case letter!');
            WHEN pv_char1_in BETWEEN 'A' AND 'Z' THEN
                dbms_output.put_line('"'||pv_char1_in||'" is an upper-case letter!');
            WHEN pv_char1_in BETWEEN '0' AND '9' THEN
                dbms_output.put_line('"'||pv_char1_in||'" is a number!');
            ELSE
                dbms_output.put_line('"'||pv_char1_in||'" is something else!');
        END CASE;
      END;
      
BEGIN
    lv_char_list := list('G', 'c', '2', '%');
    
    FOR i IN 1..lv_char_list.COUNT LOOP
        char_type(lv_char_list(i));
    END LOOP;
    
    char_type(lv_char1_other, lv_char2_other);
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
END;
/