--DROP TYPE silvan_t;

SPOOL silvan_t.txt

/* CREATE SILVAN_T TYPE DEF */
CREATE OR REPLACE
  TYPE silvan_t UNDER elf_t
  ( elfkind VARCHAR2(30)
  , CONSTRUCTOR FUNCTION silvan_t
    ( elfkind VARCHAR2 ) RETURN SELF AS RESULT
  , MEMBER FUNCTION get_elfkind RETURN VARCHAR2
  , MEMBER PROCEDURE set_elfkind (elfkind VARCHAR2)
  , OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
  INSTANTIABLE NOT FINAL;
/

/* CONFIRM SILVAN_T */
DESCRIBE silvan_t;

/* CREATE SILVAN_T TYPE BODY */
CREATE OR REPLACE
  TYPE BODY silvan_t IS
 
    /* Formalized default constructor. */
    CONSTRUCTOR FUNCTION silvan_t
    ( elfkind VARCHAR2 ) RETURN SELF AS RESULT IS
    BEGIN
      /* Assign an oname value. */
      self.oid   := oid;
      self.oname := oname;
      self.name    := name;
      self.genus   := genus;
      self.elfkind := elfkind;
 
      RETURN;
    END;
 
    /* A getter function to return the elfkind attribute. */
    MEMBER FUNCTION get_elfkind RETURN VARCHAR2 IS
    BEGIN
      RETURN self.elfkind;
    END get_elfkind;
    
    /* A setter procedure to set the elfkind attribute. */
    MEMBER PROCEDURE set_elfkind
    ( elfkind VARCHAR2 ) IS
    BEGIN
      self.elfkind := elfkind;
    END set_elfkind;
    
    /* A to_string function. */
    OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
    BEGIN
      RETURN (self AS elf_t).to_string||'['||self.elfkind||']';
    END to_string;
  END;
/

SPOOL OFF

QUIT;