/*
   Name:   lab2part2.sql
   Author: Adrian Lane
   Date:   19-01-2019
*/
 
-- Put code that you call from other scripts here because they may create
-- their own log files. For example, you call other program scripts by
-- putting an "@" symbol before the name of a relative file name or a 
-- fully qualified file name. 
 
 
-- Open your log file and make sure the extension is ".txt".
SPOOL lab2part2.txt
 
-- Add an environment command to allow PL/SQL to print to console.
SET SERVEROUTPUT ON SIZE UNLIMITED
SET VERIFY OFF
 
-- Put your code here,
DECLARE
    lv_raw_input VARCHAR(30);
    lv_input     VARCHAR(10);
    
BEGIN
    -- Get input from the user or argument
    lv_raw_input := '&1';
    -- Check for no input / blank
    IF NVL(lv_raw_input IS NULL,TRUE) THEN
        lv_input := 'World';
    -- Truncate raw input if needed
    ELSIF NVL(LENGTH(lv_raw_input) > 10,TRUE) THEN
        lv_input := SUBSTR(lv_raw_input, 1, 10);
    -- Assign raw input to display variable
    ELSE
        lv_input := lv_raw_input;
    END IF;
    
    -- Display greetings
    dbms_output.put_line('Hello '||lv_input||'!');
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_Line(SQLERRM);
END;
/
 
-- Close your log file.
SPOOL OFF
 
-- Instruct the program to exit SQL*Plus, which you need when you call a
-- a program from the command line. Please make sure you comment the 
-- following command when you want to remain inside the interactive
-- SQL*Plus connection.
QUIT;