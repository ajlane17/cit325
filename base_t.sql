DROP SEQUENCE tolkien_s;
DROP TABLE tolkien;
DROP TYPE teleri_t;
DROP TYPE sindar_t;
DROP TYPE silvan_t;
DROP TYPE noldor_t;
DROP TYPE orc_t;
DROP TYPE man_t;
DROP TYPE maia_t;
DROP TYPE hobbit_t;
DROP TYPE goblin_t;
DROP TYPE elf_t;
DROP TYPE dwarf_t;
DROP TYPE base_t;

SPOOL base_t.txt

/* CREATE BASE_T TYPE DEF */
CREATE OR REPLACE
  TYPE base_t IS OBJECT
  ( oid   NUMBER
  , oname VARCHAR2(30)
  , CONSTRUCTOR FUNCTION base_t
    ( oid   NUMBER
    , oname VARCHAR2 ) RETURN SELF AS RESULT
  , MEMBER FUNCTION get_oname RETURN VARCHAR2
  , MEMBER PROCEDURE set_oname (oname VARCHAR2)
  , MEMBER FUNCTION get_name RETURN VARCHAR2
  , MEMBER FUNCTION to_string RETURN VARCHAR2)
  INSTANTIABLE NOT FINAL;
/

/* CONFIRM BASE_T */
DESCRIBE base_t;

/* CREATE BASE_T TYPE BODY */
CREATE OR REPLACE
  TYPE BODY base_t IS
 
    /* Formalized default constructor. */
    CONSTRUCTOR FUNCTION base_t
    ( oid   NUMBER
    , oname VARCHAR2 ) RETURN SELF AS RESULT IS
    BEGIN
      /* Assign an oname value. */
      self.oid   := oid;
      self.oname := oname;
 
      RETURN;
    END;
 
    /* A getter function to return the oname attribute. */
    MEMBER FUNCTION get_oname RETURN VARCHAR2 IS
    BEGIN
      RETURN self.oname;
    END get_oname;
 
    /* A setter procedure to set the oname attribute. */
    MEMBER PROCEDURE set_oname
    ( oname VARCHAR2 ) IS
    BEGIN
      self.oname := oname;
    END set_oname;
    
    /* A getter function to return the name attribute. */
    MEMBER FUNCTION get_name RETURN VARCHAR2 IS
    BEGIN
      RETURN NULL;
    END get_name;
 
    /* A to_string function. */
    MEMBER FUNCTION to_string RETURN VARCHAR2 IS
    BEGIN
      RETURN '['||self.oid||']';
    END to_string;
  END;
/

SPOOL OFF

QUIT;