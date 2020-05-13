/* Set environment variables. */
SET PAGESIZE 9999

/* Write to log file. */
SPOOL create_tolkien.txt

/* Drop the tokien table. */
DROP TABLE tolkien;

/* Create the tokien table. */
CREATE TABLE tolkien
( tolkien_id        NUMBER
, tolkien_character base_t);

/* Drop and create a tolkien_s sequence. */
DROP SEQUENCE tolkien_s;
CREATE SEQUENCE tolkien_s START WITH 1001;

/* Verify table structure */
DESCRIBE tolkien;

/* Close log file. */
SPOOL OFF

/* Exit the connection. */
QUIT;