/*
||  Name:          apply_plsql_lab12.sql
||  Date:          11 Nov 2016
||  Purpose:       Complete 325 Chapter 13 lab.
||  Dependencies:  Run the Oracle Database 12c PL/SQL Programming setup programs.
*/

/* Cleanup */
DROP FUNCTION item_list;
DROP TYPE item_tab;
DROP TYPE item_obj;

-- Open log file.
SPOOL apply_plsql_lab12.txt

/* Create ITEM_OBJ Oject */
CREATE OR REPLACE TYPE item_obj IS OBJECT
( title        VARCHAR2(60)
, subtitle     VARCHAR2(60)
, rating       VARCHAR2(8)
, release_date DATE );
/

-- Verify Object
DESC item_obj;

/* Create ITEM_TAB Collection of ITEM_OBJ */
CREATE OR REPLACE TYPE item_tab IS TABLE OF item_obj;
/

-- Verify object
DESC item_tab;

/* Create ITEM_LIST Function */
CREATE OR REPLACE FUNCTION item_list
    ( pv_start_date DATE
    , pv_end_date   DATE DEFAULT (TRUNC(SYSDATE) + 1) ) 
    RETURN item_tab IS
    
    -- Record type to hold returned data
    TYPE item_rec IS RECORD
    ( item_title        VARCHAR2(60)
    , item_subtitle     VARCHAR2(60)
    , item_rating       VARCHAR2(8)
    , item_release_date DATE );
    
    -- NDS cursor
    item_cur SYS_REFCURSOR;
    
    -- Row for output from NDS cursor
    item_row ITEM_REC;
    item_set ITEM_TAB := item_tab();
    
    -- Dynamic statement
    stmt VARCHAR2(2000);

BEGIN
    -- Create dynamic statement
    stmt := 'SELECT item_title, item_subtitle, item_rating, item_release_date '
         || 'FROM item '
         || 'WHERE item_rating_agency = ''MPAA'''
         || 'AND item_release_date > :start_date AND item_release_date < :end_date';

    -- Open and read NDS cursor         
    OPEN item_cur FOR stmt USING pv_start_date, pv_end_date;
    
    LOOP
        -- Fetch cursor data into item_row
        FETCH item_cur INTO item_row;
        EXIT WHEN item_cur%NOTFOUND;
        
        -- Assign data into collection
        item_set.EXTEND;
        item_set(item_set.COUNT) :=
            item_obj( title        => item_row.item_title
                    , subtitle     => item_row.item_subtitle
                    , rating       => item_row.item_rating
                    , release_date => item_row.item_release_date );
    END LOOP;
    
    -- Return the data set
    RETURN item_set;
    
END item_list;
/
    
-- Verify function
DESC item_list;

/* Test Case */
COL TITLE  FORMAT A60
COL RATING FORMAT A8
SELECT il.title
,      il.rating
FROM   TABLE(item_list('01-JAN-2000')) il
ORDER BY 1, 2;

-- Close log file.
SPOOL OFF
