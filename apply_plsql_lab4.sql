SET SERVEROUTPUT ON SIZE UNLIMITED
SET VERIFY OFF

SPOOL c:\oracle\apply_plsql_lab4.txt;

-- User-defined object
CREATE OR REPLACE
    TYPE lyric IS OBJECT (
        day_name   VARCHAR2(8),
        gift_name  VARCHAR2(24));
/

DECLARE
    -- User-defined types           
    TYPE list IS TABLE OF VARCHAR2(8);
    TYPE lyrics IS TABLE OF lyric;
    
    -- Static collections
    lv_days LIST := list( 'first',
                          'second',
                          'third',
                          'fourth',
                          'fifth',
                          'sixth',
                          'seventh',
                          'eighth',
                          'ninth',
                          'tenth',
                          'eleventh',
                          'twelfth');
                          
    lv_lyrics LYRICS := lyrics(lyric('and a', 'Partridge in a pear tree'),
                               lyric('Two', 'Turtle doves'),
                               lyric('Three', 'French hens'),
                               lyric('Four', 'Calling birds'),
                               lyric('Five', 'Golden rings'),
                               lyric('Six', 'Geese a laying'),
                               lyric('Seven', 'Swans a swimming'),
                               lyric('Eight', 'Maids a milking'),
                               lyric('Nine', 'Ladies dancing'),
                               lyric('Ten', 'Lords a leaping'),
                               lyric('Eleven', 'Pipers piping'),
                               lyric('Twelve', 'Drummers drumming'));
                
BEGIN
    -- Loop through the days
    FOR i IN 1..lv_days.COUNT LOOP
        dbms_output.put_line('On the '||lv_days(i)||' day of Christmas');
        dbms_output.put_line('my true love sent to me:');
        -- For each day, list the gifts given in relyric order
        FOR j IN REVERSE 1..i LOOP
            -- If it's the first day, replace "and a" with "A"
            IF i = 1 THEN
                dbms_output.put_line('-A '||lv_lyrics(j).gift_name);
            ELSE
                dbms_output.put_line('-'||lv_lyrics(j).day_name||' '||lv_lyrics(j).gift_name);
            END IF;
        END LOOP;
        -- Separate each outer loop iteration with a line break
        dbms_output.put_line(CHR(13));
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
END;
/

SPOOL OFF;