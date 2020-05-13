SET SERVEROUTPUT ON SIZE UNLIMITED
SET VERIFY OFF

DECLARE
    -- User-defined types
    TYPE list IS TABLE OF VARCHAR2(12);
    
    -- Record to store input
    TYPE three_type IS RECORD (
        xnum    NUMBER,
        xstring VARCHAR2(30),
        xdate   DATE
    );

    -- Variables
    lv_input1 VARCHAR(100);
    lv_input2 VARCHAR(100);
    lv_input3 VARCHAR(100);
    lv_input_list LIST;
    lv_record THREE_TYPE;
        
    -- FUNCTION verify_date
    --   Accepts VARCHAR2 date string masked as 'DD-MON-RR' or 'DD-MON-YYYY'
    --   Returns DATE if pattern matches and date is valid, otherwise returns NULL
    FUNCTION verify_date
      ( pv_date_in  VARCHAR2) RETURN DATE IS
      /* Local return variable. */
      lv_date  DATE;
    BEGIN
      /* Check for a DD-MON-RR or DD-MON-YYYY string. */
      IF REGEXP_LIKE(pv_date_in,'^[0-9]{2,2}-[ADFJMNOS][ACEOPU][BCGLNPRTVY]-([0-9]{2,2}|[0-9]{4,4})$') THEN
        /* Case statement checks for 28 or 29, 30, or 31 day month. */
        CASE
          /* Valid 31 day month date value. */
          WHEN SUBSTR(pv_date_in,4,3) IN ('JAN','MAR','MAY','JUL','AUG','OCT','DEC') AND
               TO_NUMBER(SUBSTR(pv_date_in,1,2)) BETWEEN 1 AND 31 THEN 
            lv_date := pv_date_in;
          /* Valid 30 day month date value. */
          WHEN SUBSTR(pv_date_in,4,3) IN ('APR','JUN','SEP','NOV') AND
               TO_NUMBER(SUBSTR(pv_date_in,1,2)) BETWEEN 1 AND 30 THEN 
            lv_date := pv_date_in;
          /* Valid 28 or 29 day month date value. */
          WHEN SUBSTR(pv_date_in,4,3) = 'FEB' THEN
            /* Verify 2-digit or 4-digit year. */
            IF (LENGTH(pv_date_in) = 9 AND MOD(TO_NUMBER(SUBSTR(pv_date_in,8,2)) + 2000,4) = 0 OR
                LENGTH(pv_date_in) = 11 AND MOD(TO_NUMBER(SUBSTR(pv_date_in,8,4)),4) = 0) AND
                TO_NUMBER(SUBSTR(pv_date_in,1,2)) BETWEEN 1 AND 29 THEN
              lv_date := pv_date_in;
            ELSE /* Not a leap year. */
              IF TO_NUMBER(SUBSTR(pv_date_in,1,2)) BETWEEN 1 AND 28 THEN
                lv_date := pv_date_in;
              ELSE
                lv_date := NULL; -- changed from SYSDATE
              END IF;
            END IF;
          ELSE
            /* Assign a default date. */
            lv_date := NULL; -- changed from SYSDATE
        END CASE;
      ELSE
        /* Assign a default date. */
        lv_date := NULL; -- changed from SYSDATE
      END IF;
      /* Return date. */
      RETURN lv_date;
    END;
    
BEGIN
    -- Get input from user
    lv_input1 := '&1';
    lv_input2 := '&2';
    lv_input3 := '&3';
    
    -- Put our inputs into a list for looping through
    lv_input_list := list(lv_input1, lv_input2, lv_input3);
    
    -- Loop through the inputs and parse the type
    FOR i IN 1..lv_input_list.COUNT LOOP
    
        -- If number
        IF REGEXP_LIKE(lv_input_list(i),'^[[:digit:]]*$') THEN
            lv_record.xnum := lv_input_list(i);
            
        -- If alphanumeric
        ELSIF REGEXP_LIKE(lv_input_list(i),'^[[:alnum:]]*$') THEN
            lv_record.xstring := lv_input_list(i);
            
        -- If date
        ELSIF verify_date(lv_input_list(i)) IS NOT NULL THEN
            lv_record.xdate := lv_input_list(i);
            
        END IF;
    END LOOP;
    
    -- Output the record
    dbms_output.put_line('Record  ['||lv_record.xnum||'] ['||lv_record.xstring||'] ['||lv_record.xdate||']');

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
END;
/
QUIT;
