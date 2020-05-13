--DROP TYPE dwarf_t;

SPOOL dwarf_t.txt

/* CREATE DWARF_T TYPE DEF */
CREATE OR REPLACE
  TYPE dwarf_t UNDER base_t
  ( name  VARCHAR2(30)
  , genus VARCHAR2(30)
  , CONSTRUCTOR FUNCTION dwarf_t
    ( name  VARCHAR2
    , genus VARCHAR2 ) RETURN SELF AS RESULT
  , OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2
  , MEMBER PROCEDURE set_name (name VARCHAR2)
  , MEMBER FUNCTION get_genus RETURN VARCHAR2
  , MEMBER PROCEDURE set_genus (genus VARCHAR2)
  , OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
  INSTANTIABLE NOT FINAL;
/

/* CONFIRM DWARF_T */
DESCRIBE dwarf_t;

/* CREATE DWARF_T TYPE BODY */
CREATE OR REPLACE
  TYPE BODY dwarf_t IS
 
    /* Formalized default constructor. */
    CONSTRUCTOR FUNCTION dwarf_t
    ( name  VARCHAR2
    , genus VARCHAR2 ) RETURN SELF AS RESULT IS
    BEGIN
      /* Assign an oname value. */
      self.oid   := oid;
      self.oname := oname;
      self.name  := name;
      self.genus := genus;
 
      RETURN;
    END;
 
    /* A getter function to return the name attribute. */
    OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2 IS
    BEGIN
      RETURN self.name;
    END get_name;
    
    /* A setter procedure to set the name attribute. */
    MEMBER PROCEDURE set_name
    ( name VARCHAR2 ) IS
    BEGIN
      self.name := name;
    END set_name;
    
    /* A getter function to return the genus attribute. */
    MEMBER FUNCTION get_genus RETURN VARCHAR2 IS
    BEGIN
      RETURN self.genus;
    END get_genus;
 
    /* A setter procedure to set the genus attribute. */
    MEMBER PROCEDURE set_genus
    ( genus VARCHAR2 ) IS
    BEGIN
      self.genus := genus;
    END set_genus;
 
    /* A to_string function. */
    OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
    BEGIN
      RETURN (self AS base_t).to_string||'['||self.name||']['||self.genus||']';
    END to_string;
  END;
/

SPOOL OFF

QUIT;